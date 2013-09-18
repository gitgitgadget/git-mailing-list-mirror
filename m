From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Locking files / git
Date: Thu, 19 Sep 2013 02:34:36 +0530
Message-ID: <523A1564.2080107@gmail.com>
References: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 23:04:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMOvW-0003Gm-Gb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 23:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694Ab3IRVEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 17:04:42 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:45853 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab3IRVEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 17:04:41 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so8764627pad.2
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=I1cXvyRUPTeCgHrcjwbzUcShFW7u2f/wcsFg2rFELs8=;
        b=sPuW6tvUiORWitjo+Gh8gJtDqX4M1NsFUPZhdUJhUfq82kfnQYOOrc9qPW6vQwSYfy
         Y8yUG4d7fS4KUsz9oqAqB7iTZwWjI9Re5MIC2Q+pmNW7Ay5qZPFwbVnzSn2ODaEWaZkv
         q45RJui1Um5kSPIf6V8a0F65E9jWiR6VZi34cH1qtHa4xRirwPcWeSmvTkxDnO1uJQP1
         monqWoTXzCCbCckcTQsn0xDucX0MgVAP1wCiI7Sb3wr7BMVeHIZQkP1odL67JjEITKX7
         RalGFQ7/TRI0rzbUwvCWrmLZ/NferNmbWbR8Nb16UAI4WlYpJltosIJClKP26cp742mr
         zuHg==
X-Received: by 10.68.234.41 with SMTP id ub9mr3503580pbc.201.1379538280924;
        Wed, 18 Sep 2013 14:04:40 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.209.115])
        by mx.google.com with ESMTPSA id ye1sm7229820pab.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 14:04:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234994>

On 09/18/2013 01:15 AM, Nicolas Adenis-Lamarre wrote:
> Ooops. It seems that each time somebody says these two words together,
> people hate him, and he is scorned by friends and family.
> 
> However,
> - gitolite implement it (but gitolite is not git).

No.  It pretends to implement it, for people who absolutely must have
something and are willing to play by the rules.

Quoting from the doc [1], "When git is used in a truly distributed
fashion, locking is impossible".

I wrote it as a sort of bandaid, and that is all it is.  "Implement" is
too kind a word.

regards

sitaram
