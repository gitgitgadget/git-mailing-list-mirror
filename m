From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Wed, 30 Jan 2013 10:36:10 +0700
Message-ID: <CACsJy8COCpr_CvQPhBFtVnsKztA3xgo01=zKG4WPcFfCbNTmgw@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091610.GD9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 04:37:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0OTv-00025s-7R
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 04:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab3A3Dgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 22:36:42 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33986 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab3A3Dgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 22:36:41 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so1184255obb.22
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 19:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QpekdMTpn9n6lJOokg6plEEpnbMJFDNf0TLOndrvk3Q=;
        b=k/nwXnad1OhkugMLgEKYCmGbehwwmPEwusttHrxnciB/0ZWlvKe9V+Xs5V8q1KtQxr
         SptPlI71U9t7orUqxVqBY8CIfDfE/iYLMWavSu2VgkXRLgOt2Lu92q9JRRSGsA8u4GrG
         SaNEljYjRTVqCJDIFOvdtEZsVSAslbzaY6spjE024iqcD4FvVmLZPLdmV7mMQKWFXqU4
         GoJi8wIf3Sw4/k3dfR97q2fLzHLTTm7xjOVGzSO3v9/hneJlzkvngBvDKrC8spp8YPpe
         q5YgvmtRBsK8ikTI2xDzIVuFdaPk3v15OoQFZP23tC9MzbbvZrR3h+yc+/rCaPdphYkr
         +Lnw==
X-Received: by 10.60.32.44 with SMTP id f12mr2682591oei.61.1359517001035; Tue,
 29 Jan 2013 19:36:41 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 29 Jan 2013 19:36:10 -0800 (PST)
In-Reply-To: <20130129091610.GD9999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214992>

On Tue, Jan 29, 2013 at 4:16 PM, Jeff King <peff@peff.net> wrote:
> +int commit_metapack(unsigned char *sha1,
> +                   uint32_t *timestamp,
> +                   unsigned char **tree,
> +                   unsigned char **parent1,
> +                   unsigned char **parent2)
> +{

Nit picking. tree, parent1 and parent2 can/should be "const unsigned char **".
-- 
Duy
