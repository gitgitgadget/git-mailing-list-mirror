From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] Tests file for git-remote-mediawiki
Date: Fri, 08 Jun 2012 10:57:39 +0200
Message-ID: <vpqboku18qk.fsf@bauges.imag.fr>
References: <4FCE07A5.9020001@ensimag.imag.fr>
	<1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1338902756-4162-3-git-send-email-simon.cathebras@ensimag.imag.fr>
	<vpqobow8a9l.fsf@bauges.imag.fr> <4FD1B209.702@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, charles.roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, peff@peff.net, gitster@pobox.com,
	Charles Roussel <charles.roussel@ensimag.fr>
To: Simon.Cathebras@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 10:58:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scv1n-0000bR-Lt
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 10:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934025Ab2FHI6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 04:58:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57737 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab2FHI6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 04:58:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q588muE8027632
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 10:48:56 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Scv0m-0007UP-LQ; Fri, 08 Jun 2012 10:57:40 +0200
In-Reply-To: <4FD1B209.702@ensimag.imag.fr> (Simon Cathebras's message of
	"Fri, 08 Jun 2012 10:04:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 10:48:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q588muE8027632
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339750140.75668@4OQora+UXtH6WJVCBvZnFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199471>

"Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> writes:

> On 06/06/2012 22:18, Matthieu Moy wrote:
>> Simon Cathebras<simon.cathebras@ensimag.imag.fr>  writes:
>>
>>> From: Charles Roussel<charles.roussel@ensimag.fr>
>>>
>>> Those scripts test the functions of git-remote-mediawiki.
>>> t9360: test cases for git clone. Including tests of cloning just a category, just a precise set of page and a classical use of clone on the whole wiki.
>> Avoid long lines in code and commit messages (80 columns max)
> Understood, it will be corrected in the next patch.

Detail: in emails, people generally leave blank lines to separate
paragraphs, and in particular to separate one's own text from citation.
Compare my response

  http://thread.gmane.org/gmane.comp.version-control.git/199238/focus=199349

to yours to see what I mean

  http://thread.gmane.org/gmane.comp.version-control.git/199238/focus=199468

> Do you mean that we should split the third patch into two patches ?
> For instance::
>     Patch 3/4: tests for git pull
>     Patch 4/4: tests for git push

Yes, except the title should mention git-remote-mediawiki, of course.

>>> +test_expect_success 'git clone only create Main_Page.mw with a wiki with no other pages ' '
>>> +        wiki_reset&&
>>> +        wiki_editpage foo "this page must be delete before the clone" false&&
>> s/delete/deleted/
>>> +	git_diff_directories mw_dir ref_page&&
>> functions in tests are usually prefixed with test_ instead.
> Fair enough. We have changed the function's name. Should we add such
> prefix on functions like wiki_reset or wiki_delete page ?

I don't think so. They're not very specific to testing indeed, and
really are specific to the wiki OTOH.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
