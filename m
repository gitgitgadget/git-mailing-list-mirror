From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Feature or a bug: git aliases are executed in git-root directory
Date: Wed, 14 Apr 2010 15:10:42 +0200
Message-ID: <g2hfabb9a1e1004140610mdd7b093arb15758ba40fd7956@mail.gmail.com>
References: <4BC5A483.6060206@plusserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jens Otten <j.otten@plusserver.de>
X-From: git-owner@vger.kernel.org Wed Apr 14 15:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O22TB-0006Bh-0j
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 15:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352Ab0DNNRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 09:17:23 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43557 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0DNNRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 09:17:22 -0400
Received: by gwaa18 with SMTP id a18so49827gwa.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=nT+KqWBjLVbLwFwftoWf6e9vD2mvOXxICDtTm4uCTVU=;
        b=k2UgF6XSiaPJ69QmVB2odVUNSf1D4cjxy7SLcWSy6nVFeivRok4uFmS3SKsArOOsMt
         gxL9x1ZMpwDyCe7BHUDOH9nckSEQKi4iwovXVKkkRMPCyKPRqdy4T16zKyf3lNeo7g+G
         BBDlT3huvmNQx222S1H7qcapo6GDZkxxDItuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WG0XDGcbcI2qhiF+/Ru2BENRFU0+1l/OEzyIEZRov50Pkt7fkqzI8KO51DMK8TGykZ
         Upega+VBJYDwVMAxV82k079xk54jduK9GDKc0BRaX2C3ZNVQT+UQPoKsMcVbqpblV/DT
         sXNxM2Xkq8PCRvkjNmj7iPxtVE+H2Pr3rhcCQ=
Received: by 10.100.206.13 with HTTP; Wed, 14 Apr 2010 06:10:42 -0700 (PDT)
In-Reply-To: <4BC5A483.6060206@plusserver.de>
Received: by 10.101.9.21 with SMTP id m21mr13431980ani.119.1271251039483; Wed, 
	14 Apr 2010 06:17:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144869>

Heya,

On Wed, Apr 14, 2010 at 13:18, Jens Otten <j.otten@plusserver.de> wrote:
> is there a way to solve this problem?

Yes, put this script in your path (and make it executable):

cat > git-meld << EOF
#!/bin/sh

GIT_EXTERNAL_DIFF='git-diff-to-meld-redirect' git diff "$@"
EOF

-- 
Cheers,

Sverre Rabbelier
