From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Re: [Patch 0/5] Create single PDF for all HTML files
Date: Mon, 8 Oct 2012 23:53:18 +0100
Organization: OPDS
Message-ID: <4F18F2E9D9ED4F8C94701472A190D01E@PhilipOakley>
References: <20121006193205.GD3644@sigill.intra.peff.net> <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net> <1770841099.101310.1349597668191.JavaMail.ngmail@webmail23.arcor-online.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Thomas Ackermann" <th.acker66@arcor.de>, <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 00:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLMC9-0007uY-LL
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 00:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab2JHWwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 18:52:53 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:64565 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755191Ab2JHWwv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2012 18:52:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq0MAOVYc1BcGnKf/2dsb2JhbABFi1CyVAECgQmBCYIbBQEBBQgBAQ4gEQUIAQEhCwIDBQIBAw4GAQMJJRQBBBgCBgcXBgEHCwgCAQIDAQwEh1IDEwewUwWJXIphZgprgQqBO4F5YAOII4VGiRePGYJgDg
X-IronPort-AV: E=Sophos;i="4.80,556,1344207600"; 
   d="scan'208";a="406047167"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip01ir2.opaltelecom.net with SMTP; 08 Oct 2012 23:52:49 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207279>

From: "Thomas Ackermann" <th.acker66@arcor.de>
>
> There are "patched QT" and "unpatched QT" versions of wkhtmltopdf
> (see http://code.google.com/p/wkhtmltopdf/). I am using V0.9.9 for 
> Windows
> which is "patched QT".
>
> There is one drawback with wkhtmltopdf: At least on my Netbook (Win7 
> 64bit,
> Pentium 1.5GHz) it is very slow. It takes more than 3 hrs to create 
> git-doc.pdf.
>
> If you want to have a quick look on the resulting pdf just clone
> https://github.com/tacker66/git-docpdf.git. This repo contains
> a current version of user.manual.pdf and git-doc.pdf
>

Even as a 'draft' I found it to be useful to see all the documentation 
collated together in one place/pdf. All 763 pages!

Even just reading through the contents list (34 pages) showed the scale 
of the git documentation, and areas of documentation I wasn't aware of.

Putting the Tutorials, Everyday GIT and workflows at the beginning 
looked good.

For a polished version it would be good if the major breaks (e.g. 
between ToC, gittutorial, git-add [should start with git(1)], 
gitattributes, GIT Howto, API, Git Index Format, ReleaseNotes) could 
start on a new page.

A few minor nits: I wasn't sure if the 'fighting regressions with git 
bisect', and 'a short git tools survey' were in the right place. There 
appear to be two 'git-send-pack' titles, though they are different. And 
the HowTo section would need some beefed up headings to give them enough 
prominence in the ToC once it all hangs together.

>
> ----- Original Nachricht ----
> Von:     Jeff King <peff@peff.net>
> An:      Thomas Ackermann <th.acker66@arcor.de>
> Datum:   06.10.2012 21:32
> Betreff: Re: [Patch 0/5] Create single PDF for all HTML files
>
>> On Sat, Oct 06, 2012 at 05:51:15PM +0200, Thomas Ackermann wrote:
>>
>> > I wanted to have a single PDF file which contains the complete Git
>> documentation
>> > (except user-manual) for easier reading on my tablet. The simplest 
>> > way to
>> do
>> > this was by using wkhtmltopdf which can combine a set of HTML files 
>> > into a
>> sinlge
>> > PDF file and also apply some reformatting. To this end HTML files 
>> > for all
>> the missing
>> > files in Documentation/technical and Documentation/howto and also 
>> > for all
>> the
>> > release notes in Documentation/RelNotes were created.
>>
>> It seems like a reasonable goal. I do not have a strong opinion on 
>> the
>> approach or how the final output looks, but I wasn't able to actually
>> get output at all after applying your patches. Running "make fullpdf"
>> (after installing dblatex) got me:
>>
>>   The switch --book, is not support using unpatched qt, and will be
>>   ignored.The switch --footer-html, is not support using unpatched 
>> qt,
>>   and will be ignored.The switch --disable-external-links, is not
>>   support using unpatched qt, and will be ignored.
>>
>> after which wkhtmltopdf began pegging my CPU. I let it run for 10
>> minutes before giving up.
>>
>> Another way of doing this would be to format the individual troff
>> manpages into dvi or postscript, convert that into pdf, and then
>> concatenate that. Something like:
>>
>>   for i in *.[157]; do
>>     man -Tdvi -l "$i" >"$i.dvi"
>>     dvipdfm "$i"
>>   done
>>   pdftk *.[157].pdf cat output full.pdf
>>
>> works for me, though obviously that does not handle some of the 
>> non-man
>> items you included. No idea on how the output compares to yours, but
>> it's something you may want to look at.
>>
>> -Peff
>>
>
> ---
> Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.2677 / Virus Database: 2591/5813 - Release Date: 
> 10/06/12
> 
