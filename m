From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 1/3] add splash screen
Date: Thu, 29 Oct 2009 13:48:07 +0100
Message-ID: <4AE98F07.4050401@gnu.org>
References: <20091029002229.GA986@sigill.intra.peff.net> <20091029002400.GA1057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 13:48:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3UQO-0006St-Dj
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 13:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbZJ2MsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 08:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZJ2MsI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 08:48:08 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63449 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZJ2MsG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 08:48:06 -0400
Received: by yxe17 with SMTP id 17so1601222yxe.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lu5BpMMKCvUYb7HhJ+vjfNJ9YVhErU6U0B5JswOvqRw=;
        b=aqAr/lsNUx/C2sRizwmb7wDjfKwc88ZQ9iH77Qisbq4Uw6uGlynNL+7O4mpq4x15gG
         dCnMUx7aLOqfk8IeD74zuJ3kuZmBFTjcPxZWzbFadYtw1dnbQ/O7ba9H5Yaqp/nYUn6L
         YccN/6xmHvz2DEAHRWRdcbfJqAPymVi36S98o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QAJ90i83OqpUslqiaBW4CAp/szpOMPV9EsC3XKltsB5RRra6aWfRYRTRL527tyZjHO
         wqU9aEKQ5NJhShNPwoQgKDhtHUY10eOyYFXtyFBy3h44LKWhqgWBKGW4H7UD8FeRdfkR
         GLupJzXAkeh++Vsguf16XfIUWplejOznEpUG4=
Received: by 10.150.87.4 with SMTP id k4mr189900ybb.347.1256820491545;
        Thu, 29 Oct 2009 05:48:11 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id 16sm339375gxk.7.2009.10.29.05.48.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 05:48:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <20091029002400.GA1057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131587>

On 10/29/2009 01:24 AM, Jeff King wrote:
> Because bash completion is so slow to start, we need to
> entertain users with a splash screen, so reuse the one from
> git-gui.

I suggest adding "wm overrideredirect . 1; wm geometry . +300+300".

Paolo
