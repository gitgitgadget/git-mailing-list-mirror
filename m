From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Should git-citool be in mainporcelain in command-list?
Date: Mon, 6 Sep 2010 17:07:57 -0500
Message-ID: <20100906220757.GH26371@burratino>
References: <AANLkTi=Hn_GG1y3gkVxgnsKyVD+VutG5SU5HhmhRfktH@mail.gmail.com>
 <20100906213937.GF26371@burratino>
 <AANLkTimRoAgAtrkpyd08mVG93prQ40B1y=ReLRdNfbWt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 00:10:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsjtQ-0004is-TY
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 00:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab0IFWKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 18:10:20 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48267 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab0IFWKB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 18:10:01 -0400
Received: by qwh6 with SMTP id 6so4158187qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JqByabf4FmSu8raxBzb/vkkyypDQTpH5zxxw6/+gwIA=;
        b=NKBxfFXy1aawh/Dr3PRSxeRS56T1z/kMbcDN4MaM2Gjspo4EVc7LwKEDsSqI2tdTzA
         RF9GOYP4O4nK73QVhZM6xUF5bsBQPigSZ5EW/uV614VqUJLAZ3tHfWZnPpd78dvrOhML
         PsmF6Ei7zvDDVgWSBPEKKmlxtPYyhjeMTNPMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bHIPYmWVxxV0KxIvyrKc9RFKgnS/mB8aAVVUHyio4NpTipHaU9eB/+Oy6Lxz01krvR
         fKfxyfpBoC/4SckegSI2js8uSfa2BFIoZpR1BT5hFFsQziedgYoliQGj2787unzG7oFP
         oIvCOAtMecK500V8zaZlpQbFDKmmIsv2gOLiQ=
Received: by 10.229.189.195 with SMTP id df3mr4029192qcb.143.1283811000435;
        Mon, 06 Sep 2010 15:10:00 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r36sm6159142qcs.3.2010.09.06.15.09.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 15:09:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimRoAgAtrkpyd08mVG93prQ40B1y=ReLRdNfbWt@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155632>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The entries in git(1) don't indicate that citool is a convenience
> alias for git-gui:

That's because it isn't, no?

SYNOPSIS
       git citool

DESCRIPTION
       A Tcl/Tk based graphical interface to review modified
       files, stage them into the index, enter a commit message
       and record the new commit onto the current branch. This
       interface is an alternative to the less interactive git
       commit program.

       git citool is actually a standard alias for git gui
       citool. See git-gui(1) for more details.
