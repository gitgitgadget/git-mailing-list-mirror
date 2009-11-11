From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 20/24] http-fetch: add missing initialization of
 argv0_path
Date: Tue, 10 Nov 2009 19:52:45 -0600
Message-ID: <20091111015245.GA9027@progeny.tock>
References: <20091109150235.GA23871@progeny.tock>
 <1257779104-23884-20-git-send-email-jrnieder@gmail.com>
 <7vpr7q6sw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 02:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N82Ei-0006pP-Np
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 02:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbZKKBmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 20:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756365AbZKKBmh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 20:42:37 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38582 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362AbZKKBmg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 20:42:36 -0500
Received: by yxe17 with SMTP id 17so573124yxe.33
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=v22dVvGA7pfopRf55xVKF9aIJLtUrwkO/h7Y2S3uFmQ=;
        b=Y5pKVCqXK55uKg9TZl0S3o0BEm7+tALzDolfF+C8XJ8Q9i78Iv6l36bxujaV2K+ko1
         XPdXWb6iEKCwsxknOz1YLMBzQylUKlsp8vpAq+Xv8EsCS8m9fsQPsGGvYlwWJi+pbS01
         /4MKIwaemjZ+YEgs1/PitEV5enuskD1xrkla8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EAmngFygjnPBYij9BRWqd8vFzoTiQmvuwlFESM5SpIRZUYEXjb1A/IM8z8DzeSJ0q2
         HwsydKXZkcHZmCwPH/FyFaUS5O1sJ+qeOzokWo7zBf3InMYIL7K2xgQsf/nl+gwHAZlc
         F5d3S0vmD/SE5XxJzEq0F7EDC6fXKs8X/vdmI=
Received: by 10.150.172.39 with SMTP id u39mr1638316ybe.43.1257903762338;
        Tue, 10 Nov 2009 17:42:42 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm576634gxk.0.2009.11.10.17.42.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 17:42:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpr7q6sw8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132607>

Junio C Hamano wrote:

> Why do you have inclusion of "exec_cmd.h" in [19/24]?  As far as I can
> tell, nothing you do in that patch depends on it.

No good reason.  Thanks for cleaning up my mess.

Jonathan
