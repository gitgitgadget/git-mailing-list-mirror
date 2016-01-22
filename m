From: Santiago Torres <santiago@nyu.edu>
Subject: Re: GIT Question
Date: Fri, 22 Jan 2016 12:58:16 -0500
Message-ID: <20160122175815.GA28871@LykOS>
References: <1E23015B9294604195E5EBA53602E115FCEE7D@WDC-VMAILBOXP25.smrcy.com>
 <alpine.DEB.2.20.1601221750060.2964@virtualbox>
 <1E23015B9294604195E5EBA53602E115FCF59F@WDC-VMAILBOXP25.smrcy.com>
 <alpine.DEB.2.20.1601221803560.2964@virtualbox>
 <1E23015B9294604195E5EBA53602E115FCF5B7@WDC-VMAILBOXP25.smrcy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Draggs, Tori" <Tori.Draggs@Mercy.Net>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:58:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMfyZ-0005u7-P0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbcAVR6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:58:20 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33810 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbcAVR6T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:58:19 -0500
Received: by mail-qg0-f43.google.com with SMTP id 6so63051517qgy.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=zwSajkljyUxCP+DtFx0301rkTEmRQ+2Dr3fowbwzftU=;
        b=LzwnUWsKt1pKq7+PTKOEuASKp0iw3TCJydL1bJcvbx6WSOvtxZj3lA4/uuBr5O6SLc
         +6fjlPyK6SQwTX6DniPTzA4tmg2qOrBkFqdXKqbEc9MzPjmhVsZv/0SUdK98SiNQ3ewc
         MgrZ/tzwtipKyumcD/cfKhQdKGDEDImewDsEnaMQzv8rgHGYzqqvqERAMnx2s/Va3QgS
         xQn9nxBLxBDlL/3q1aH74WHaddEWibEAAK99VodO+GuP8RQg9hTm19kj65bfAqhq57ZT
         h2jiddD93HcRZTXrejbbqTuM+k+BFZf4xot735FQ90O6wnluYRDoWO+iKH4jjuhRgaf0
         oAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=zwSajkljyUxCP+DtFx0301rkTEmRQ+2Dr3fowbwzftU=;
        b=Wube/LWi0lpHuGex6KFDIZzJwaGBnyqajsUJ2pISPWiCZXQSaOZEra9B8Glqp3jsZ9
         mhEGIUf3RpGwaigOSElbAcV5PQRewOFisSZzX24PczhEoGmz5C8LrfgxNsw0mGc/BmM/
         IKTRgKEdObzubDc41UOsIYWMA4wAvv/DEHMR00OsY/ZkSXF6KhIaiFE7H064LDpSLX7b
         QcFmAUAeMdIM70ht5gzJHvfm0pgN22dtMxhd5tqp+r+n0lnmFw2gbi+891YCBFEjzRAo
         pHNXAGg9uuHndGr8b75TzEezKYAS85p6nVYRvd8SNJOdndqpA/RMwLPoHDGhmOvnXvt2
         pqUg==
X-Gm-Message-State: AG10YORMVrfeWagJf6f8PLr0ZIiGGZXK+nHnIlnsiitN6ykutfQrx/vI0RBlGogGwOQUcgKH
X-Received: by 10.140.86.85 with SMTP id o79mr5261505qgd.3.1453485498270;
        Fri, 22 Jan 2016 09:58:18 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id v74sm3229885qka.7.2016.01.22.09.58.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jan 2016 09:58:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1E23015B9294604195E5EBA53602E115FCF5B7@WDC-VMAILBOXP25.smrcy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284574>

On Fri, Jan 22, 2016 at 05:22:16PM +0000, Draggs, Tori wrote:
> I apologize, however my intent in reaching out was not to seek free of cost help desk services.

Don't worry, just use reply to all so everyone can see and chime in if
they can help.

> > Hi.  I am able to pull up Visual Studio Code.  But none of my local
> > files.  I tried using the magnifying glass as well as the Go To feature
> > and when performing a search I am informed that the file is not found. 

I see you were able to run git log, what do you see in it? as it might
shed some light on what happened.

-Santiago.
