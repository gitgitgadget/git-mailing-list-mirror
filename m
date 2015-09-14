From: Breanna Devore-McDonald <Breanna.S.Devore-McDonald.1@nd.edu>
Subject: Developing- Where to Start
Date: Mon, 14 Sep 2015 16:42:31 -0400
Message-ID: <CAMTS3bMxb1ak4YHTEU7FYoLVnkmV=4NehQ+obCSp9gV6gFBx_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 22:43:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbaaY-0004g6-LM
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 22:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbbINUmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 16:42:43 -0400
Received: from mail-msa6-prod-v.cc.nd.edu ([129.74.13.15]:20781 "EHLO
	mail-msa6-prod-v.cc.nd.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751896AbbINUme (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 16:42:34 -0400
X-Greylist: delayed 5347 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2015 16:42:34 EDT
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com [209.85.214.171])
	by mail-msa6-prod-v.cc.nd.edu (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t8EKgWmb028404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
	for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:42:33 -0400
DKIM-Filter: OpenDKIM Filter v2.7.5 mail-msa6-prod-v.cc.nd.edu t8EKgWmb028404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nd.edu; s=msa-bulk;
	t=1442263353; bh=7AdsfV/XH3MAnWmtIThVnv6thGPv6YstigwlzNrB8rI=;
	h=Date:Subject:From:To;
	b=V1Og/7BrEdB+bkHGgstbThcUqJlJo5hQYMvEKpacZJD38jOO4cg6Hlx3RH9OGveT8
	 7tOxOG+hMUkrHCL3/9zmVJOZ43TyeUJk8Pp5ToQ/onQqzUKyniOhhk7tKrQNlVY/2q
	 6Go0Pw8Jp89Qt6tw9apXMqeO9BECygLV3ebC2lE4=
Received: by obbbh8 with SMTP id bh8so118488047obb.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 13:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=7AdsfV/XH3MAnWmtIThVnv6thGPv6YstigwlzNrB8rI=;
        b=av8/QsJmVmu8Cp989GIT79p64dRIXs1E1uDx9PyMJfPpqeesZ5RDfzLlJuDW5xi8ni
         tgg5ATTsR1nHVESqN8bzgIFuoYGGWEsxrJxIwvdVNKqASCVJuoNlpm5yauds5XGfI8ce
         enM4tkndn76fRluwa/T+3wk3fmv57GyTmzAp4W0TLwhSIdqF8GY6vC3lyzJ6wSlLSS5+
         U9/dxDDSNTfFoYzJ8RXt4MmnN8g/qaqNbrZv0jVDcd7GREWKsZjC1havuHBqqQpcZwiH
         mPQ9yuqZlsz3k4TlbFlwbYab+7dlhIGStaKz9gYdvM48kuM5MYzGytb8pOwWOsjwIGfh
         zVig==
X-Gm-Message-State: ALoCoQm9GXFNPVBUZmgnxp2LrKBK8kb+pL3E50Q4L9kCHOeF1bDdvMfB3t3QqKXzDdHN227fn0m6L462bx0XmswH/UlGM31d+qBteyqAu/E6xxNGUv+e5As1NoDt6uZnQ96iMXNKAVDN
X-Received: by 10.182.225.138 with SMTP id rk10mr14237855obc.2.1442263351920;
        Mon, 14 Sep 2015 13:42:31 -0700 (PDT)
X-Received: by 10.182.225.138 with SMTP id rk10mr14237846obc.2.1442263351815;
 Mon, 14 Sep 2015 13:42:31 -0700 (PDT)
Received: by 10.202.226.12 with HTTP; Mon, 14 Sep 2015 13:42:31 -0700 (PDT)
X-ND-MTA-Date: Mon, 14 Sep 2015 16:42:33 EDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277864>

Hello all,

I'm a third year Computer Science student at the University of Notre
Dame, and for the final project of my Data Structures class, my group
and I have to find a way to contribute our (hopefully) newly-found
data structures and optimization knowledge to a well-known open source
project. We thought Git would be a great project to work on, but we
have no idea where to start. Can anyone offer ideas or parts of the
code that we could possibly help with? (a problem that is data
structures-related would be extremely helpful!)

Many thanks,
Breanna Devore-McDonald
