From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] daemon: be strict at parsing parameters
 --[no-]informative-errors
Date: Fri, 20 Dec 2013 10:46:44 -0800
Message-ID: <20131220184644.GA10609@google.com>
References: <1387536832-650-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 20 19:47:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu569-0008Lw-OK
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 19:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab3LTSqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Dec 2013 13:46:53 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:57200 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab3LTSqw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 13:46:52 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so689982yhz.8
        for <git@vger.kernel.org>; Fri, 20 Dec 2013 10:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1j78W1YF/UObSmrWFv/VC32L7MMMjRl2C2f3pYVlKMI=;
        b=fy7RJNxgVHIG5FZsYwMMbtwIW3MQ5UAIgPtPGaZxOoUZUQgmK8ktEkkrjVjkrJWP1Z
         5Fijdo9aJKzv55dRTc+8+slNtZhH8mr0euOVryAxF20gJckka6v8BZz7GccRsFDVBlZw
         my4AwXv1/i+pps5G9hepKR/81ue7U/bb5yv60u0CdU9xP5vHH0mygSeJAr7WF64Ey58t
         //c5EAZrtuwwwPUy+E7M+dcKbxP23viCHd0XyBw4iGxk6OIQso+UZS6Eg8X5OT8E3ln0
         Jsm34Bp/uD/LpK6zWvNYfJiKXeebv8yz3sza0mAlMxmE5e2O+F6lIjjct8E83cmsCfFQ
         rzSg==
X-Received: by 10.236.41.133 with SMTP id h5mr7074925yhb.22.1387565212170;
        Fri, 20 Dec 2013 10:46:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id l65sm12450022yhk.1.2013.12.20.10.46.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Dec 2013 10:46:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387536832-650-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239577>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Use strcmp() instead of starts_with() to stop accepting
> --informative-errors-just-a-little
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Good catch.  When this use of prefixcmp was introduced in
v1.7.8-rc0~28^2 (daemon: give friendlier error messages to clients,
2011-10-14) I think it was just a typo.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
