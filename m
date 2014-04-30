From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git cascade and git forward-merge
Date: Tue, 29 Apr 2014 19:05:54 -0500
Message-ID: <53603e62cd48a_3136105d3089d@nysa.notmuch>
References: <3C0A37210D5D044AB99EEAE13ADA186B08DAB8@NYPRMBX03.WNYC.ORG>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "ram@rachum.com" <ram@rachum.com>
To: Schuyler Duveen <sduveen@nypublicradio.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 02:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfICQ-0007dQ-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 02:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398AbaD3AQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 20:16:30 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:50752 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757403AbaD3AQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 20:16:30 -0400
Received: by mail-yh0-f49.google.com with SMTP id t59so986288yho.8
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=bmiqvvd61jxp2DnPC35DRvawC3x+RWF84v12A8qI4GY=;
        b=oa2cRqE5mlMe+RkuMg/rhqVW5U+hNmvq4QJlf3gGnUd3xCSGn0lKx5Ab/XnzxMR+Eu
         COqeK7D5LFXVpTPbnWAHaaAUX5a5+QK11hPZkHRhZD6Wp5wEL1ckrWnAS0Y9TfPnpXGv
         lB9zV4aHiSJw7b4chUx3X1GadJPrFBHiLLDq0NxiEtiaG7KRTBW6ueto94l40OBUmiC9
         hcHeHtpmTe2gRfQkkga07Fk78QStkmEuLkTfQRoEAwIQ2DWe+xSX/oGztZpm8nkk2H8U
         rk09RJeJn9Ke+e6cFHK1WrF6MpK1RSXt3HqoNzbHb+DsuiJNk06UoAkHk6mfzOXbqRsd
         0odw==
X-Received: by 10.236.118.206 with SMTP id l54mr1216459yhh.97.1398816989396;
        Tue, 29 Apr 2014 17:16:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id q66sm39704487yhj.44.2014.04.29.17.16.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 17:16:28 -0700 (PDT)
In-Reply-To: <3C0A37210D5D044AB99EEAE13ADA186B08DAB8@NYPRMBX03.WNYC.ORG>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247667>

Schuyler Duveen wrote:
> This was a feature that I've really wanted for a while.  I took a bit
> of time to morph the most conservative version of forward-merge into
> pure-shell script:
> 
> https://github.com/schuyler1d/git-forward-merge/
> 
> Without strong objections, I'm going to try to make this into a patch for core.

I like this, but I think it should be an option to `git merge`.

-- 
Felipe Contreras
