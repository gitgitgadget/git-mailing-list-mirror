From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v5 27/28] http tests: use /dumb/ URL prefix
Date: Sun, 1 Nov 2009 22:50:57 +0800
Message-ID: <be6fef0d0911010650o746df5c3x938695700041d31a@mail.gmail.com>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
	 <1256950067-27938-29-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 01 15:51:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4bln-0008M8-KE
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 15:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbZKAOux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 09:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZKAOux
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 09:50:53 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58421 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbZKAOuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 09:50:52 -0500
Received: by gxk4 with SMTP id 4so3497236gxk.8
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 06:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=TH5mQJ3g6Bg2lj8jquc8NUdrJgUgTog7P8VfXbtMjeI=;
        b=YcWacWIgEBfuGYMC/cgHPPAoeBd1lETQTlUCoYQY82VaqZmTGj+GUiu7WyAEc21onx
         RRDGw1Oa6s4xjqBVmjPYr4bVk8wnZf6CtlB7R2J/ocw9rZL06x+c33R8Uhhj+ubm0R9T
         S90UUmYpuBnP5A2wvT8dopbLf8OHlHqAPOo+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HGNJA7ABW1xl+Ro8icgS5YGOAUZFIv9OToxgoR6J8ghSGwrvprs4Omeg5idEcYaEPL
         3bLS+kohSgps6PD/KdOb7u+CZwfnjd8lb4dKjr1DX1qDKfUATMs+Bb81/cUiXlk5OFKP
         4gVJ/Xv/4KT3ewhPPiTP33W5sG8bAVXv2XDRw=
Received: by 10.91.192.14 with SMTP id u14mr8018869agp.2.1257087057463; Sun, 
	01 Nov 2009 06:50:57 -0800 (PST)
In-Reply-To: <1256950067-27938-29-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131871>

Hi,

On Sat, Oct 31, 2009 at 8:47 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> To clarify what part of the HTTP transprot is being tested we change
> the URLs used by existing tests to include /dumb/ at the start,
> indicating they use the non-Git aware code paths.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> CC: Tay Ray Chuan <rctay89@gmail.com>

thanks.

Acked-by: Tay Ray Chuan <rctay89@gmail.com>

-- 
Cheers,
Ray Chuan
