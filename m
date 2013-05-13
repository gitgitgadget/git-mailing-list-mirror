From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Mon, 13 May 2013 11:52:32 -0700
Message-ID: <20130513185232.GA3657@google.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
 <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com>
 <20130511061322.GB3394@elie>
 <20130511094119.GA6196@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 13 20:52:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbxrZ-00060a-Te
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 20:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab3EMSwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 14:52:42 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:57950 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab3EMSwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 14:52:41 -0400
Received: by mail-da0-f48.google.com with SMTP id h32so2488854dak.35
        for <git@vger.kernel.org>; Mon, 13 May 2013 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=r32FCXPCfS6McRA90Q13iA8XEd/BzN8/z+sn2gp+uew=;
        b=w2NUAQ87B3qHjJ7MCll4cyhpUCjleyOTPugwvWkT4m+B57QrsxRUCR1gMuFG7Hd+qd
         89vmTX/FS25E7d8OR3L2m22JKdan3ZXloNGw0acE4fcOt5Tvb+2nPXyvUpV3jmkYiNZw
         0G3r0iIkebw+Ig3/hssse9DbtLORqZReh5GSSbqwJOHOoA5XADji7YGoY4fVDqg6UFWd
         Jf9ok7L3dcZYlWd+fXiv/0WklFWIZm6jdUxdijdwmKqcwlJj3p6gbvMsn6NybTgyPsEH
         WSy0+njz+Y81n7yPdxDLNcHquT6JU3D7dsIIUXaFZ2LHdhZazpCQK8wY/pLXi6KCgyc1
         gOoQ==
X-Received: by 10.66.121.234 with SMTP id ln10mr29903879pab.129.1368471160928;
        Mon, 13 May 2013 11:52:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id aj2sm15025208pbc.1.2013.05.13.11.52.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 11:52:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130511094119.GA6196@iris.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224190>

Paul Mackerras wrote:

> How about "changing lines matching:"?

Sorry for the slow response.  Sounds perfect.

Thanks,
Jonathan
