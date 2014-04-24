From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 13:38:08 -0500
Message-ID: <53595a107cf1f_3241f112ec72@nysa.notmuch>
References: <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, James Denholm <nod.helm@gmail.com>,
	David Lang <david@lang.hm>, Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOhZ-00078P-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbaDXSsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:48:43 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:35621 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758784AbaDXSsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:48:36 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so3119717oag.3
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Pl2VD2+x/uSxy3IlANlgDpF+pyrP3PUtbCmrZv7sqrM=;
        b=VY98rUdE7AbWvvh4HW7nXrtXWJCeK2rJ8mi+KMZB963Y5qRbOXbjqIZLpAyRg+Rhjw
         5hw4ec2mbSYBf6SCjHKiXWALicU+2dR/IvyusIcDGEWKI+ke9GrATAguJFLrVkfCacYX
         sQcOJx16kbf/nz76h1P0xL5yfZHO39CD3RXzBhURnOZNGBVrj1KqaIRUofQdZXJGUI0x
         AbQj7ybDx+sNCk2ksY8lN2+bpLozd6nnspmgg2IzDdEgMFtvNVT3RAX0YnF9wnEfLrXR
         rnajQCyEY9pp9yF19imT+jon7eETiWQvTie6HUFKejS1hU75umYRZLLARp4JFMUQ0awS
         6f3w==
X-Received: by 10.182.27.133 with SMTP id t5mr2772429obg.65.1398365316341;
        Thu, 24 Apr 2014 11:48:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm10154643obc.13.2014.04.24.11.48.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 11:48:34 -0700 (PDT)
In-Reply-To: <20140424134106.GA27035@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246996>

Theodore Ts'o wrote:
> On Thu, Apr 24, 2014 at 03:23:54AM -0500, Felipe Contreras wrote:
> > 
> > There is evidence for the claim that there won't be those problems. You have
> > absolutely no evidence there there will.
> 
> It's clear that you've not been able to produce evidence that can
> convince most of the people on this thread.

Which only proves you don't want to be convinced, no evidence could convince
you.

> I don't even think we need to query the user to fill out all of the
> fields.  We can prepopulate a lot of the fields (name, e-mail address,
> etc.) from OS specific defaults that are available on most systems ---
> specifically, the default values we would use the name and e-mail
> address are not specified in a config file.

Most systems don't have a configured $EMAIL, so those defautls would be wrong.

It's so evident that no evide could convince you that you don't even bothere to
answer my question:

Why does Mercurial, Bazaar, Subversion, CVS, and pretty much everything uses
aliases?

Since you are conveniently not answering, I'll answer for you:

Because such hypothetical problems wouldn't actually occur in reality with Git,
just like they don't occur in other tools.

-- 
Felipe Contreras
