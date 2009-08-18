From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 15:01:28 +0200
Message-ID: <4A8AA628.8040208@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Aug 18 15:01:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOJy-0001Kr-59
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 15:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbZHRNBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 09:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZHRNBc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 09:01:32 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:40216 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbZHRNBb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 09:01:31 -0400
Received: by bwz22 with SMTP id 22so2996220bwz.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=xQvvhONdPrgpYpi9U9gukUvtm9D6Gk9NrCveNmTysLU=;
        b=xVaTcmOyFXb1CnYHz02KxoIElTzKTAUZq9XDi2UXnk61VyarwyemIk8MDaTLVlh4UP
         +CI4fBoEoBmZBxOFWQT+nodccg33lBMEPxEvZUA2Mzgo34q3QbWb39SsHx7o4QW+8y6F
         4GvOEUdt5hIXFhen8ZA+hbdgru5MrYM6rrv7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=AZ6nX2iqOTbYKbLImgxZDb5ah5mB5WJ/zn7FnXzaYNQyUot6C/mEBhneA/1cf8PUaQ
         yxcyO8AzcjI2oXCqkiFovz9MOiY3UMaUN+jFhxX4ZQGYMZZNRrQBzjamOKhd9bxXlP0q
         K9WuIjKAKEGcO/aNl2dSsB8OktxTNJ/BoGf2Y=
Received: by 10.204.7.75 with SMTP id c11mr3761902bkc.119.1250600492203;
        Tue, 18 Aug 2009 06:01:32 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id y15sm6641563fkd.47.2009.08.18.06.01.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 06:01:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Lightning/0.9 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <1250600335-8642-1-git-send-email-mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marius Storm-Olsen said the following on 18.08.2009 14:58:
> This is a rudementary patch, only meant as an RFC for now!!
> 
> !! DO NOT COMMIT THIS UPSTREAM !!

..meaning in this case Frank Li's repo, and obviously not git.git. :p

--
.marius
