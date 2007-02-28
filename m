From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Wed, 28 Feb 2007 15:41:38 +0000
Message-ID: <200702281541.41164.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 16:41:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQw9-0004dg-Ds
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbXB1Pls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Feb 2007 10:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXB1Pls
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:41:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:39956 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbXB1Plr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Feb 2007 10:41:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so590419nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 07:41:45 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WlPns2K9u/1FHYURuWzhapn35VsvND6bS/QylB3gnHBBGLLUc8EgvoEPWQ6iKDABvUigE3F6Xcn0x6Y5pvragPFNHbB2JKjKCMjGks2PuBW5bunf0HsiOmH/PibxY4D9tLluOgRvhAc0naX+nE4NRJFjmVhGYjXf93RNxmgGyO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y3ss8yH/2vgqQGy/XN799ekIcUDeuV8NTYQ7Z3qWW16C7wcgNTgExJSPCn5xq5pc560yJ4mt0g8r0I9jqs1UbY5ctWonIjQRrBPoYfcfSilC8WD/x8B4V//8E5LQN6PPCMyhcF3Z+rMFH7qvvXY97bAY55HIJ49G7AhKqgIve58=
Received: by 10.49.91.6 with SMTP id t6mr3821625nfl.1172677305815;
        Wed, 28 Feb 2007 07:41:45 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id x27sm6092209nfb.2007.02.28.07.41.43;
        Wed, 28 Feb 2007 07:41:43 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070228151516.GC57456@codelabs.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40944>

On Wednesday 2007 February 28 15:15, Eygene Ryabinkin wrote:
> --- http-push.c.orig=A0=A0=A0=A0Wed Feb 28 15:15:01 2007
> +++ http-push.c=A0Wed Feb 28 15:15:21 2007
> @@ -1295,7 +1295,7 @@

A patch for git that wasn't made with git.

Don't take this the wrong way Eygene, but why?



Andy
--=20
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
