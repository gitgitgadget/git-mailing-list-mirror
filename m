From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: How can I tell if a file is ignored by git?
Date: Thu, 8 Apr 2010 21:10:49 -0700
Message-ID: <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 06:11:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O05Ys-000376-0N
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 06:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab0DIELN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 00:11:13 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:43744 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab0DIELM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 00:11:12 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1068766qwh.37
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 21:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=ekZvpIdKmZgK3EhkD/DzTUrcx6vt1f4aQyfOfSKI0lk=;
        b=A5RV4xV1Z0EjbFuI9qstsW9OPXqKzc/8VactGcvrDhvbcpS/Y2tousypXfRxZx89O+
         fvG4Ac+TLMeT1XYQHbd1AF1XINixDZb8M63+j1Uar2NGigNBp5ZRdYN74GaQqtFQTDCt
         I3/CgXpeYFCOhiPC2k6oza8VlnoAvjBo5dfoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bkU5YK8EKl/24gM5+W7SEZjuHTkPlLUocA+HlaWk2EipKO3uJ+xjMDidgZ2dXvpVrs
         xgjX1NwFjozaDkrB1fDvW1iB2Mt95JrVj6HPSErHlaGf+X4w7FBJ35Eaaav2oHXS1Nvw
         x4kI/tlD9tQKv0v/ZUFPXvzeT3WqsyP81OF/Y=
Received: by 10.229.215.2 with HTTP; Thu, 8 Apr 2010 21:10:49 -0700 (PDT)
In-Reply-To: <20100409040434.8602620CBBC@snark.thyrsus.com>
Received: by 10.229.251.72 with SMTP id mr8mr1857139qcb.30.1270786271445; Thu, 
	08 Apr 2010 21:11:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144395>

On Thu, Apr 8, 2010 at 21:04, Eric Raymond <esr@snark.thyrsus.com> wrote:
> I'm planning some work on Emacs VC mode.
>
> I need a command I can run on a path to tell if it's ignored by git.

What about a variant of:
    git ls-files -i -o --exclude-standard
