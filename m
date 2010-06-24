From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] Export parse_date_basic() to convert a date string to 
	timestamp
Date: Thu, 24 Jun 2010 20:32:51 +0200
Message-ID: <AANLkTikkR3KaMPcltwJslAxna25bmFixIKLsGzf55_ZW@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624105146.GA12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 20:33:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORrEk-0002Kg-FE
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 20:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab0FXSdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 14:33:13 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47045 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0FXSdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 14:33:12 -0400
Received: by qyk38 with SMTP id 38so280885qyk.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nhp1BmZ7p9uRTKPdDCDb7NWo/VPu/kbO8tVyVg6fXYQ=;
        b=ak6ItnfOUtnX56PMzdwwHjWrqeT7UbW5w1kju7kUq96abioQULgQvR0ILCt2lT3PPY
         /j1I8TpEs8huSS0BLZm/LUwT0CGBKO6ndrGYaTjPxkAGHYlhCKvu1Qcz7NVlDR/xjc4i
         FxodI3BNSyhE7NoH/dk47cwnZAa02Pu9IY+bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mZpdCiuEoG8OEG+T0bNbVFyFpi2MzwwzMX770Y1vwX9HJTWCym4l6vAKL1bPG6MdsM
         U1UZdhm8qaIdAwnET4MUlhoh2jKwCjYm27pp7qyPyCQFGJHY1RJKuSI1fNj/wYf8Jhmh
         VNXuEwWG8p7olosAb0sTiEXsduhgpbtTEVmAM=
Received: by 10.224.96.78 with SMTP id g14mr6507902qan.117.1277404391322; Thu, 
	24 Jun 2010 11:33:11 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 11:32:51 -0700 (PDT)
In-Reply-To: <20100624105146.GA12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149617>

Hi Jonathan,

This specific patch is clear. I have some issues with some of the
other parts in the series.

Jonathan Nieder wrote:
> approxidate() is not appropriate for reading machine-written dates
> because it guesses instead of erroring out on malformed dates.
> parse_date() is less convenient since it returns its output as a
> string. =C2=A0So export the underlying function that writes a timesta=
mp.

Right. I couldn't justify exposing it in the series that's in master no=
w.

> While at it, change the return value to match the usual convention:
> return 0 for success and -1 for failure.

Since I'm to blame for this change,
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- Ram
