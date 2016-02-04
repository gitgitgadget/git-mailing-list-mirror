From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Wed, 03 Feb 2016 20:12:32 -0500
Organization: Twitter
Message-ID: <1454548352.5545.2.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1454443734.5545.1.camel@twopensource.com>
	 <xmqq7fimrcab.fsf@gitster.mtv.corp.google.com>
	 <xmqqmvrhjpzc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:13:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR8Tv-0001VU-CC
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 02:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbcBDBNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 20:13:07 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34871 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964842AbcBDBMf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 20:12:35 -0500
Received: by mail-qg0-f53.google.com with SMTP id o11so30218312qge.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 17:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=UJpK8hO1wAnC3gT+ImnhncbMp6+wjGp89i5JsBasPiA=;
        b=T36VglB/p7dpKfzWBSftLqVcVs4pELO+WIphkMF0p61bM9IX2cTKBB4PlsKFTqB/iG
         NY/fr+1FXqnh8n3fCY8qK5cMvlJdj4pteqPMKopSZj4JA3zI6N8Gw6IrThPHmf1cAvJZ
         Xn/9lMbgRbBeER5S1H1ssVONFb9jNBQc11F9tgl7xR6GFQRY/GUtBqQ/8IEYEjIBRhNg
         8TefuvkQ1IcJZFdYGbsnKjQhMkz35k0QuCQlTpcQHk7VB8HxxzcMxROmznA8QQ+dIVkO
         CGBsGlCdtduqrsB+Ei5V3cQ/PWz9WevWOIrfuHJJr2Jo7CnGAO3u0ltte4g2ZB95oWZT
         mTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=UJpK8hO1wAnC3gT+ImnhncbMp6+wjGp89i5JsBasPiA=;
        b=UfREZlrQ3X4XcgAG1oOIIzwpA/+XBscuj7fIukHRKhVR6qj2+7V/A+Bp2HuPfuPP90
         5FC8dnsZGkmEHP/jc7tvr6eEi9TUQTp/eiIn0XG2MLprej7QLDqrGOC4fyEzXUcATsrX
         sMLjWQ4J5eAfn9iLk+/ypyxlPhJOF9HvynZejHZsY6ePTqcGJtHc3N6EE1Ww+EDFuqgd
         5LF4arJa7JqarGMPC11XLBR7dOv82eHC/SZpNfLepExkQTYnxi2/fj/P4T7H5HHCHrVM
         pSMAUAHnK2xXHmQuQobrlz2lV7MGbQIrl3L1lKKBn+slyHMIql57kRoBooi21d9zKHxJ
         jPpQ==
X-Gm-Message-State: AG10YOTyUZWOI1Lm5KxnYHVhzAXD0mdUisSBAgRlJ9QbyAuylZ1XtKQCUECe5V1hdQO31A==
X-Received: by 10.140.178.195 with SMTP id y186mr6086404qhy.100.1454548354369;
        Wed, 03 Feb 2016 17:12:34 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v187sm3662651qhb.27.2016.02.03.17.12.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Feb 2016 17:12:33 -0800 (PST)
In-Reply-To: <xmqqmvrhjpzc.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285389>

On Wed, 2016-02-03 at 16:09 -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > David Turner <dturner@twopensource.com> writes:
> > 
> > > Are there any more reviews on this?  I do have some changes from
> > > this
> > > set, but they're pretty minor so I don't want to post a new one
> > > (unless
> > > folks would rather see those changes before reviewing).  Let me
> > > know.
> > 
> > Thanks for pinging.  As this is a rather wide-ranging topic, it was
> > not practical to intergrate with the rest of the topics in flight
> > back then, but now it seems that this needs only one topic that
> > still is in flight.  I'll queue this on top of a merge between
> > 'master' and the tip of 'sb/submodule-parallel-update' and include
> > in the daily integration cycle to make it easy for people to view
> > the changes in wider context as necessary.
> 
> I've re-applied the patches to rebuild the topic; when merged to
> 'pu' it seemed to break some tests, but I didn't look too deeply
> into it.

They were working for me as-of the time I sent them.  I guess something
must have broken since.  I'll rebase, test, and send a new series.
