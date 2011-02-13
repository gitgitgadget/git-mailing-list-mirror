From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Subject: Consistent terminology: cached/staged/index
Date: Sun, 13 Feb 2011 20:20:56 +0100
Message-ID: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 20:21:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PohVk-0001wt-Sm
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 20:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab1BMTVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 14:21:00 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35492 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab1BMTU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 14:20:57 -0500
Received: by vxb37 with SMTP id 37so2245773vxb.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=Ny6hw/r5ys71J+Y/tIRsfP7jB3+Di3M32+OZXFoUbBA=;
        b=O2RzKev+WQKPUtTQ1IwSOsBTTKDv3IJtkAOUufYn62EwOWy7C138UgwuzxByGkJ4Aj
         ZCeIcB5fGGjUcpK8u2VOt9XNF6aXaRmk+2LFwB7ecpsklVowOTiufjPmtj07JkzYeuMO
         sgAD/psKc240nuuGhJx6JHsNiwETOj0qngIEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=Q3wa9wkgBimf6F57iJ1VKbzPlXo25veWEYnoQh7oNEE4NRjC4LIOd7UjkAiwoyb0Ll
         rr4buJsKXI6F/ZWD+ZcueVIG1Ma+K8GytC0hMt2E6p6zarhVdbzWBkKgKmxqtnARxjHY
         2yuoQKHIqHfM7poiYoRf0Eis2dxTE0q+f/Bqs=
Received: by 10.220.182.199 with SMTP id cd7mr3841865vcb.176.1297624856905;
 Sun, 13 Feb 2011 11:20:56 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Sun, 13 Feb 2011 11:20:56 -0800 (PST)
X-Google-Sender-Auth: 7VBNuWESx-_KtT_5AF532P2-aAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166675>

Hi,

is there a plan for using one term instead of three to describe
operations on index?

>From quick search:
* "add" mentions index and staging
* all commands except one take "--cached" only
* "diff" also takes "--staged"
* "diff" mentions index and staging
* "log" mentions index
* "reset" mentions index


-- 
Piotrek
