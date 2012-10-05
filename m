From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Ignore on commit
Date: Fri, 5 Oct 2012 08:00:12 +0100
Organization: OPDS
Message-ID: <5DB4E90436854A219805224B2C375CC9@PhilipOakley>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com> <506DEC50.7090402@obry.net> <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com> <CAH5451mpJw4+noUF+FkZJS+Y2oq2ThFeG7wSOCdbVaMQPNgUJA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <pascal@obry.net>, <git@vger.kernel.org>
To: "Andrew Ardill" <andrew.ardill@gmail.com>,
	"Marco Craveiro" <marco.craveiro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 09:00:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1tl-0001jc-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab2JEHAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 03:00:24 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:59032 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054Ab2JEHAX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 03:00:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhYKAA+FblBcGnKf/2dsb2JhbABFhg+FP7JAA4EJgQmCGwUBAQQBCAEBGRUeAQEhBQYCAwUCAQMVAwICBSECAhQBBAgSBgcXBgESCAIBAgMBh2IDCQqlYIkLDYlUgSGJOWRhhBYyYAONaYYrjHaFC4Ju
X-IronPort-AV: E=Sophos;i="4.80,540,1344207600"; 
   d="scan'208";a="395551005"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip05ir2.opaltelecom.net with SMTP; 05 Oct 2012 08:00:03 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207076>

From: "Andrew Ardill" <andrew.ardill@gmail.com>
> On 5 October 2012 07:20, Marco Craveiro <marco.craveiro@gmail.com> 
> wrote:
>> ...
>> Similar but not quite; the idea is that you know that there is some
>> code (I'm just talking about files here, so lets ignore hunks for the
>> moment) which is normally checked in but for a period of time you 
>> want
>> it ignored. So you don't want it git ignored but at the same time you
>> don't want to see these files in the list of modified files.
>
> What is the reason git ignore is no good in this case? Is it simply
> that you can't see the ignored files in git status, or is it that
> adding and removing entries to .gitignore is too cumbersome? If it's
> the latter you could probably put together a simple shell wrapper to
> automate the task, as otherwise it seems like git ignore does what you
> need.
>

IIUC the files are already tracked, and a variant of ' git 
update-index --assume-unchanged' is being requested, so that the command 
doesn't need to be repeated if they checkuout / swap branches (which 
assumes I've understood the effect of such an index change correctly)

> Regards,
>
> Andrew Ardill
> --
