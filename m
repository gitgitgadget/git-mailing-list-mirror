From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 02/17] boolean is a typedef under MSVC, so rename variable
 to 'i_boolean'
Date: Mon, 14 Sep 2009 15:41:40 +0200
Message-ID: <4AAE4814.8060902@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	lznuaa@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 15:42:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBor-0005ho-NT
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbZINNmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbZINNmE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:42:04 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:64024 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbZINNmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:42:03 -0400
Received: by ewy2 with SMTP id 2so669398ewy.17
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ZUZHT30YoWRQw1pKL3PWT+uXLVENod+E7GRs5ac+5GM=;
        b=vFOLym1hEBxQPpLqIWWDd3h8zs2mXIBUUw7BrR6a/4ViV00wtMp30UzrJEcbSyUfxV
         ErS8IQMelOJUftDXCks4jrfNFBas9pe2pS7N9yYgNy5a4ElRJ4L7ThzOvRwaaaWpvgxf
         48+hScypQor4/TGFNBtibTxcusX6mPduqAb84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=FqOzUp/mSl43TEE/kdvGmnPerdtwfKnfAUSVE1epAoD14wdH+yMnT78gfpD+rKoPKi
         oIvmLVRzFhs3vDHX4jiKwgFHd2PppMUhFtpNfk7kglAmWGVIJyfEQMDLZGoFVIluzj1f
         EgaMHF1hmSW6Rtiiq5gvqkenoEjCElIvXsJdI=
Received: by 10.211.173.17 with SMTP id a17mr3241183ebp.77.1252935725405;
        Mon, 14 Sep 2009 06:42:05 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 24sm4328967eyx.10.2009.09.14.06.42.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 06:42:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128480>

Marius Storm-Olsen said the following on 14.09.2009 15:11:
> With MSVC 'boolean' is already a typedef to unsigned char in the
> rpcndr.h in the SDK. So, just rename to 'i_boolean' to avoid 
> conflicts in this one file, instead of any include magic.

This patch can actually be dropped, since patch 12 makes the windows.h 
include "Lean and Mean", and rpcndr.h is not indirectly include 
anymore. Sorry for not spotting this before sending the series..

--
.marius
