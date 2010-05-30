From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Improve error message in rebase conflict
Date: Sun, 30 May 2010 15:35:46 +0200
Message-ID: <AANLkTilqMg-QFo5KVA1IjwnddxRYULYh4pbxbsC6TB5W@mail.gmail.com>
References: <1275222044-511-1-git-send-email-artagnon@gmail.com> 
	<AANLkTimiZlampV3xmfCyIhb1wbCUpGGYxtZpEYnmHIr1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dale Rowley <ddrowley@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 15:36:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIigZ-00024A-VL
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 15:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab0E3NgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 09:36:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33715 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab0E3NgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 09:36:07 -0400
Received: by vws11 with SMTP id 11so1047755vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=VnpXX56jh5MfbvtGLqK7NcUKxTWkkFMsN7wegzpfQv4=;
        b=B/j+Sov/+C+9KC1h2thPq4+5gRLtSBQvGdosaSDdR3QjEe5Nkz6hK01GvHGQgyhdZQ
         7+0ek5/BY9cay7ghCXrMkbj02JCmOJHbbcrRbGQ6iWoncB6REFelKoCdVDCPtT2nEjg/
         s+UJYPFHpM4QmRGC1bGijkUEKimKEzOX4oEWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=c2kIlrwtSqPiWfii9Krm85XcuyNORaA55krzXs0R4WsZzcdmXJEznyP6jGCSNf8Ps8
         GPdaWFXVwFtJPpiGG4sJQeia5W0kHvsvYxybmb0ddfGJqVxLhBTUzbI0ISAInjvAep2N
         1aKxNz0Uv3yH5fusGB51heEjcmxDnnmhCW+jc=
Received: by 10.229.221.72 with SMTP id ib8mr461260qcb.0.1275226566130; Sun, 
	30 May 2010 06:36:06 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 06:35:46 -0700 (PDT)
In-Reply-To: <AANLkTimiZlampV3xmfCyIhb1wbCUpGGYxtZpEYnmHIr1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148004>

Hi,

Sverre Rabbelier wrote:
> Why is this change not described in the commit message? :)

I thought it was too trivial to describe. Anyway, here's one:
++ Additionally, fix a line break in a message in git-rebase.sh

-- Ram
