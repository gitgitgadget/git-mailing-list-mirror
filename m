From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Sat, 21 Mar 2015 21:20:31 -0700
Message-ID: <550E430F.9010308@gmail.com>
References: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com> <1426969262.3756.1.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>, dwheeler@dwheeler.com
X-From: git-owner@vger.kernel.org Sun Mar 22 05:21:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZXNv-0001CE-2c
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 05:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbbCVEUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 00:20:36 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32970 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbbCVEUf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 00:20:35 -0400
Received: by pdnc3 with SMTP id c3so150480810pdn.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+HPwXmwxeSupY1tJQmSYkJvD5qvkqNG3hMK3pR8QPFA=;
        b=qW8/d+lXiQXdFL80HRLIid4tw1LosONxpsMOBd5mQ/jgD1XO37yNFNLEFdPKUW8P/G
         1Xb84AeSu5eNwHN3aWJx0fJ0yT965DTeIvbyzoIX4Hlm3ZOwkvDN+YmBsGcfJ8+aQsoa
         8IiLPJ5/TiONRbYa66RK9w0g4y1Fvukq/XQ0LSeeaDBabdWg5270EQadrM92yGtzlQP4
         dexpMrl8dF2PP+2wS3Hy8VHpmG1r2NoFDCfdaassmeX6oef4X6FdfwK0plCwI1yXwV3g
         HVuB4heHkLvfZordZolNUmsypIf3qxLBj68nfXjhgAqRO63+FSrQyXq8DWcW8zIfZJNz
         wEyw==
X-Received: by 10.70.87.195 with SMTP id ba3mr64425058pdb.126.1426998034947;
        Sat, 21 Mar 2015 21:20:34 -0700 (PDT)
Received: from [192.168.2.3] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id sb4sm3292180pbb.5.2015.03.21.21.20.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2015 21:20:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1426969262.3756.1.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266049>

On 21.03.2015 13:21, Dennis Kaarsemaker wrote:
> On za, 2015-03-21 at 14:06 -0400, David A. Wheeler wrote:
>> Warn cloners if there is no LICENSE* or COPYING* file that makes
>> the license clear.  This is a useful warning, because if there is
>> no license somewhere, then local copyright laws (which forbid many uses)
>> and terms of service apply - and the cloner may not be expecting that.
> 
> Please no, especially not without an option to switch this off. Git is
> not only used in open source settings, this would be highly annoying at
> $work, where no repo has (or needs) such a file.
> 

To spin this further it would be interesting to have
a server advertisement during git clone which indicates
if this setting is recommended to be set.
Then hosting sites popular in the open source world such as
github could enable this feature, and the client may enable
this for the currently cloned repository (the user may have
a global setting set to suppress this message though).

At $work the default of not advertising checking for such a
feature would be set.
