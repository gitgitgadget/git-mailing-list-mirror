From: Mimiko <vbvbrj@gmail.com>
Subject: Error compiling git when docbooc2k is custom compiled.
Date: Wed, 12 Feb 2014 08:48:34 +0200
Message-ID: <52FB1942.5060906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 12 07:48:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDTci-0006zo-0o
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 07:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbaBLGsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 01:48:40 -0500
Received: from mail-ea0-f171.google.com ([209.85.215.171]:60247 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbaBLGsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 01:48:39 -0500
Received: by mail-ea0-f171.google.com with SMTP id f15so4207274eak.30
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 22:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=+Qgx0uZl/NVt9xbgiFEHuLBbhWyhdwIIoxflBg+eASw=;
        b=t3VZUhsjSkCaGdT4D8wWQseF1GNGQ/CCgmX/46h1KDfsXnwdKCXlFafne0q+4lPEtn
         z+anMMdXkToI++4YJcX+pk/q+0si3Pl7qCLmVeMs9OLZvNR34p7Jj0AuTFF5OeUGNcwy
         M//ujeBUkFhwAYhG/2mt8kTbD6/7bO9kngIn/JdHdR96R2PfGMV6zHXB5I1uENwufN4d
         DIAsExjhcFhIOxqKJL+/UCDLsOMAQUdGeIBayz1CQMVlpY9jBp6RFizq+7fqNL7OYqwO
         88pHbie1ZXfaT+mFFwhK5wj0Bi8It+J4QR9qoz3w+1UkJv2Jc+5EPLcu+I1NeaybcGQu
         lBTQ==
X-Received: by 10.14.216.3 with SMTP id f3mr1798345eep.66.1392187718436;
        Tue, 11 Feb 2014 22:48:38 -0800 (PST)
Received: from [10.10.0.111] ([77.89.245.38])
        by mx.google.com with ESMTPSA id f45sm76802832eeg.5.2014.02.11.22.48.35
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Feb 2014 22:48:37 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241973>

Hello.

I've compiled docbook2x to --prefix=/opt/docbook2X. When building git 
make fails not finding docbook2x-texi, but /opt/docbook2X/bin is in the 
PATH. Investigating I've found that default build of docbook2X from 
sources creates file with the following names:

docbook2man
docbook2texi

So I use option --program-transform-name="s/^docbook2/docbook2x-/" when 
compiling docbook2X.

Please allow in building git detect the name of docbook2X when using 
default options when compiling docbook2X.

-- 
Mimiko desu.
