From: Christian Couder <christian.couder@gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 12
Date: Wed, 10 Feb 2016 13:48:34 +0100
Message-ID: <CAP8UFD34+QTP6QU9+1FBXG2KH5RE_y8VXywA45dNGjyZz6C6Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Eric Wong <normalperson@yhbt.net>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Aguilar <davvid@gmail.com>, Howard Chu <hyc@symas.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 13:48:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTUCG-0000We-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 13:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbcBJMsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 07:48:37 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33438 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcBJMsg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 07:48:36 -0500
Received: by mail-lb0-f170.google.com with SMTP id x4so9686015lbm.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 04:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=hI82pWnJcGjxYyh+G2wjjJyN1p88r92MqQhC2UtS2Tc=;
        b=D67A/A+k+51gRxR11ZFIY3spkaA9gJ+RnH3s4unOV5gNPmbh9C66f7e4x7sb39CH9v
         yRjkGRIKrghLP1PMU6dpfHfx3XRxCJdH++22oshIM6Rt5kPCVpOvbsNh+RZrcCT6YpZM
         Y9x1+qAu6/ONrIPcHwdHsDjNmG+gs9Yaz9GSPekhlADG/VwyNhlQz0pvlRpQlTw6WhGo
         4Ud23qt0HGDSg80bGjtoS5jdfmPt2E7EWx+s7jKEpZmopu8EWG6j6ZG1b222KQDwACPc
         FfUavEUhlbgTt++asEAM9F2/khIT+dspzaq2cqfhPUzzf4gAyxoqZY3TDHS6ozoaXAjG
         xQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=hI82pWnJcGjxYyh+G2wjjJyN1p88r92MqQhC2UtS2Tc=;
        b=L2C/WNRWTAMe7FF9XK/ZWWcx2p+Kku8DcV34z5Knc+ZuEKtMOheJAZQ0LSt8qh7edG
         ukWfVHZ3lzbqX3mqgq4b1stavm3gYgM7gJkM7eT/fxt2Czy8mJ3NedE4+r1mfIdYjIeR
         kdA6jVCdk4XvqzfLf2LHwuoRs5skWeHFo8sq/sQgz8PE+L/1ufTvguFsD7f1JMd6W0Dc
         GiPFK7yEayr/OjAxlaWMUI5KhMOaAtt2R2dYmmLIm6eMNfS08VB6bkTDM0HAUxqjL0Vm
         K9NgZdMw4psnWhoUZtxGXOOFmtjROaJvjat6hrukycojXu5axtSR82FUcTEJrPrEfWb7
         jHLw==
X-Gm-Message-State: AG10YOQXb+7pAOIof5WFZYHyPCpQamRgZ9Do2NDockd2Qa0NZZvfnD9+SpTAoBtEUyQDTl7ifml6v8KC/89ZwA==
X-Received: by 10.112.210.168 with SMTP id mv8mr9855275lbc.100.1455108514714;
 Wed, 10 Feb 2016 04:48:34 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Wed, 10 Feb 2016 04:48:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285897>

Hi everyone,

I'm happy announce that the 12th edition of Git Rev News is now published:

http://git.github.io/rev_news/2016/02/10/edition-12/

Thanks a lot to all the contributors, especially Thomas Gummerer!

Enjoy,
Christian, Thomas and Nicola.
