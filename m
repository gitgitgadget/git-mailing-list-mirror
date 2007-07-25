From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: submodule init problem
Date: Wed, 25 Jul 2007 22:40:47 +0200
Message-ID: <8c5c35580707251340n2f1a9fd2j5fdf322277d68d26@mail.gmail.com>
References: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	 <7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>
	 <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
	 <d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com>
	 <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0707201933360.14781@racer.site>
	 <7vir89fe1l.fsf@assigned-by-dhcp.cox.net>
	 <20070725081508.GN1591MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580707251325i2633777pdd7604b541506533@mail.gmail.com>
	 <Pine.LNX.4.64.0707252129150.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Junio C Hamano" <gitster@pobox.com>,
	git@vger.kernel.org, "Ricky Nite" <ricky.nite@gmail.com>,
	"Chris Larson" <clarson@kergoth.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDnft-0004b8-Kd
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762442AbXGYUkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762478AbXGYUkv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:40:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:22415 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762440AbXGYUku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:40:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so281567nze
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 13:40:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pKoU475nOIdnlHLmU3YDBT679KW2lJQ/qOXZb7l7uWn3kkHAySplG5C/Fv0h808XizV01PyxBiyi/BBSjR6Biy+Euv8R1m+Ja5CBTSLmoV+iCEYOIY84qwio09D53eSlhJrwD9ceS+P/ovBcaZtxbI+i2lwlM4D8gkU5JHd352U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cEe3MP9SOcoePpX+5BKyCZCv1mTLyC52mXA/4kKlN1NnAwQb8PCAjjjwcnyvPG1ZBWAMNFBNqjtBoSeohqNTCX5932e/zxImPF8j5mQgvhxnmXj2eJiPPtNnl8vr03HuIGa5qWDnDDYuGmGvEpbEPX2MnENch1S+NwAQA/muJvQ=
Received: by 10.114.201.1 with SMTP id y1mr995935waf.1185396047681;
        Wed, 25 Jul 2007 13:40:47 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 25 Jul 2007 13:40:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707252129150.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53716>

On 7/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 25 Jul 2007, Lars Hjemli wrote:
> >  eol='$'
> >  git config --get-regexp '^submodule\..*\.path$' "^$1$eol"
>
> Ah, now I get it.  You are looking for the _key_ whose value is "$1".

Yes

> And you do not need the eol hack.

Hmm, I tried misc. quoting/escaping without success, care to educate me?

-- 
larsh
