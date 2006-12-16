X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 00:15:23 +0100
Message-ID: <200612170015.24162.jnareb@gmail.com>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <em1erl$pne$1@sea.gmane.org> <20061216230108.GE12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 23:15:31 +0000 (UTC)
Cc: git@vger.kernel.org, Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sCKaVede0RwDt9/ixP68oGKjO55aNik99/pJJde09fmsDWbHr09HCp5wFFkhpbxvKO+1uzlJsyJyrOVC6/+JhVDyHk3WvZNbcdJ5XWrYB3FIhYu5xLVQ3fFNfCWjNsSyIq4GDNiNc9K5c7s6m9RQyV9k8XK+yz55hhQREiNvYfk=
User-Agent: KMail/1.9.3
In-Reply-To: <20061216230108.GE12411@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34656>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvikb-0000NN-4h for gcvg-git@gmane.org; Sun, 17 Dec
 2006 00:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422777AbWLPXP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 18:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422779AbWLPXP0
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 18:15:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:53263 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1422777AbWLPXPZ (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 18:15:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1172589uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 15:15:24 -0800 (PST)
Received: by 10.67.89.5 with SMTP id r5mr2424551ugl.1166310923317; Sat, 16
 Dec 2006 15:15:23 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id i39sm6752282ugd.2006.12.16.15.15.22; Sat, 16 Dec
 2006 15:15:22 -0800 (PST)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Hi!

Martin Waitz wrote:
> On Sat, Dec 16, 2006 at 07:45:11PM +0100, Jakub Narebski wrote:
>>
>> Or .gitlink file, if we decide to implement it (as lightweight checkout and
>> support for submodules which one can easily move/rename).
> 
> I still don't get the advantage of a .gitlink file over an ordinary
> repository with alternates or a symlink.

Moving or renaming the directory with a submodule. With alternates,
when you rename or move directory with a submodule, you have to add
alternate for new place / new name, or alter existing alternate.
With symlinks you risk broken symlinks.

When using alternates-like modules file, you can regenerate or
generate "alternates" on checkout, but...

With .gitlink file you can specify GIT_DIR sor submodule as given
directory relative to this directory or one of its parents, so you
can rename and move submodules freely.


P.S. The second (first?) purpose of .gitlink is to be able to have
lightweight checkout, i.e. more than one working area associated with
one repository.

P.P.S. Cc to the author of current .gitlink proposal, to Josef
Weidendorfer.
  Message-ID: <200612082252.31245.Josef.Weidendorfer@gmx.de>
  http://permalink.gmane.org/gmane.comp.version-control.git/33755
-- 
Jakub Narebski
