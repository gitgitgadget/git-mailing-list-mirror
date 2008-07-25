From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Avoid warning when From: is encoded
Date: Fri, 25 Jul 2008 18:01:31 +0200
Message-ID: <bd6139dc0807250901n7408a8e6w5dead238e897fc03@mail.gmail.com>
References: <1216991208-18782-1-git-send-email-4ux6as402@sneakemail.com>
	 <20080725131625.GA11221@toroid.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch?=" <4ux6as402@sneakemail.com>,
	git@vger.kernel.org
To: "Abhijit Menon-Sen" <ams@toroid.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 18:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMPkY-0007we-7a
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbYGYQBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 12:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbYGYQBd
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:01:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:31889 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbYGYQBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:01:32 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1357365ywe.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3dLgPuw/Iz1IX6Z1gde4IsYfF45Px6Ly6d0K2V1R0Qs=;
        b=p7ugxUnGha0Dg/mxEL3ICWYL1RRufYSxVEev2V2taqmEqL4pxMnDdUZTjogGWrjdwF
         iwuc7k8x95NXRriMX7GptFyjk9rHS0xKecrp1ToLWVuevnsNSanEhAlRy6yQmxUMZNLO
         PnHHTCDAXWf242dApiy5Ze2xb3hmd9gk1m+bY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=X0End1ihnfDJqRCGKXR2bO2ka5oYwL9L8h0CskqZ3UkD5az3qN9QU+yXXyDVDIbPZ5
         adOXkZQNHzMjmnRFFGSq7Udix1LPC5HjMBhhhgK3rbYkIwMzr8YfOQI788vNe8h3AlQk
         NPqBnZFOt1/tfn2a0vlbYr+wcL5y2pluRYGZM=
Received: by 10.143.44.17 with SMTP id w17mr593907wfj.242.1217001691571;
        Fri, 25 Jul 2008 09:01:31 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 25 Jul 2008 09:01:31 -0700 (PDT)
In-Reply-To: <20080725131625.GA11221@toroid.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90061>

On Fri, Jul 25, 2008 at 15:16, Abhijit Menon-Sen <ams@toroid.org> wrote:
> At 2008-07-25 15:06:48 +0200, 4ux6as402@sneakemail.com wrote:
>> Are there any form problems with this patch?

Usually the "comment" part is indented by at least one level, but
afaik that's just etiquette and is not mandatory.

> The patch itself also looks good to me (but I'm not sure if that means I
> should add an Acked-by: line to this message).

Acked-by is reserved for people who are "owners" of the area the patch
touches. So for example, a patch to git-gui could be Acked-by Shawn O.
Pierce, or one related to pack format by Nico (I think?). So you
should Ack it if you have done (a lot of) work in the same area as the
patch before and if the patch looks good.

-- 
Cheers,

Sverre Rabbelier
