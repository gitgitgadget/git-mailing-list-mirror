From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-import: allow "merge $null_sha1" command
Date: Sun, 22 Jul 2012 20:28:52 -0500
Message-ID: <20120723012852.GB3390@burratino>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
 <1340818825-13754-3-git-send-email-divanorama@gmail.com>
 <7v395g75gg.fsf@alter.siamese.dyndns.org>
 <20120627233931.GA3014@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 03:29:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St7So-00007e-D6
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 03:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab2GWB3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 21:29:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59905 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab2GWB3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 21:29:00 -0400
Received: by yenl2 with SMTP id l2so5003817yen.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 18:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9zjVRgRWPEIdVyIBHEYVeWhhMOK21LBDYCTWixszyrc=;
        b=NSNxMZNbDWBlcwhyslg0O26XtrwCoSzgBvyF+uAr7tlF90UaalpWqEwxo2n05bIHNX
         cN2aRHmofC9QnmHRdz3OGQaSVKuxwwyyDqgAukx4osssyhbhTHoKkVp6Ag8k1GTBtxyA
         qFWRUe9fv05nqFc/0LMmwTg/gOETNKC4h9asLOx3SLI8/GjYQGZnIPf1g7td51MwKT70
         xFhS3D74l80gQZ/Lvpfvf9uhQfBZsrm9yGAKWyWV3N8j4U0K/xRPegI8sCc38TINR/DU
         jGP41e3UUC5Q/9BZ3HMqcWZtg1mvZP3fh1fKmRbebojPvZHkBYJNFLfrONdyVL+BExAL
         Zdgg==
Received: by 10.50.191.163 with SMTP id gz3mr3802856igc.30.1343006938547;
        Sun, 22 Jul 2012 18:28:58 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id k4sm10818164igq.16.2012.07.22.18.28.56
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 18:28:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120627233931.GA3014@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201877>

Hi Dmitry,

Junio C Hamano wrote:
>> Dmitry Ivankov <divanorama@gmail.com> writes:

>>> "from $null_sha1" and "merge $empty_branch" are already allowed so
>>> allow "merge $null_sha1" command too.
>>
>> Would accepting such a "merge oops-do-not-do-anything" allow
>> exporters' job to be simpler?
>
> Good question.

I think this patch series had some good parts and I would like to pass
them to Junio when they're ready.

Can you send me the current version of the patches and remind me of
their status and what's left to be done?

Thanks much,
Jonathan
