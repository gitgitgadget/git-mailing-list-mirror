From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save
 As" emails
Date: Fri, 18 Dec 2009 23:07:08 -0800
Message-ID: <4B2C7B9C.1030404@gmail.com>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>  <1261172078-9174-1-git-send-email-bebarino@gmail.com>  <loom.20091218T223918-175@post.gmane.org> <1261173577.14059.5.camel@swboyd-laptop> <loom.20091218T234129-280@post.gmane.org> <4B2C395A.6080300@gmail.com> <4B2C66D3.1070508@byu.net> <4B2C70ED.1020602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Sat Dec 19 08:07:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLtPO-0000ji-GT
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 08:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbZLSHHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 02:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZLSHHN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 02:07:13 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60209 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZLSHHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 02:07:12 -0500
Received: by ywh12 with SMTP id 12so4164798ywh.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 23:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=90pCQYBbM4+pOLI2c25Apet2MhyvvYd+orpkmAxvrz0=;
        b=xbMbSQOZqdK7+NV9bEIkqQx0OabR3gWbplszD6ykyM7K7sc/plMRL/q2E4IUx96M5D
         wEBlKAtWoX4Q7IyGaYru8kLqxE1XYTLbu7yVfg7oHx0Sm2m22fGoOka23o2v3g5Ul+VH
         zBWxgHmMhNwHpduSKgv1qHJmEAGTejUp0WEH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=vwErI7sgSHYHCWI434H9/Y9RCnksa6mU1F2vCnVZWlGrlt7uDJ64pPfEVfYB6xbnYd
         rWkNe+rZxcjp4IJvQhcWJwu9ou43aWFfyYjOQXfUflpkkCAHLSqhfjQO2zAPMWtMTD9Q
         /3QujAAvUaeOCUTFxK2kPkayxyY4cDy2AUftc=
Received: by 10.150.55.27 with SMTP id d27mr7976317yba.8.1261206431314;
        Fri, 18 Dec 2009 23:07:11 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm2719823iwn.3.2009.12.18.23.07.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 23:07:10 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <4B2C70ED.1020602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135466>

I found this in t0022

sed -e "s/\$/
^M/" "$TEST_DIRECTORY"/t0022-crlf-rename.sh>elpmas&&

so I'd like to use that if possible.
