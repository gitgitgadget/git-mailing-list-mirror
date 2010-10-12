From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] fast-import: Allow cat command with empty path
Date: Tue, 12 Oct 2010 17:47:51 -0500
Message-ID: <20101012224751.GD15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-4-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 00:51:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ngk-0005Ii-AY
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 00:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab0JLWvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 18:51:13 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37808 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0JLWvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 18:51:12 -0400
Received: by qyk5 with SMTP id 5so1062889qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TuzqlfTfpVCm5OsaDgeIY+KSQDjTG0iijD5epFdzxVU=;
        b=nR1JPmXCEzaBlp9edDtLt+inKDQsunJu3IZ2v+eW+plm3UusuUPsPiO1H6sb0A0XF1
         tVSwJO85RDosj1kjjBP9vr11G82KO16pWy57DrSU8lAHApKKtFUuvDDsfZmMrhD1qm1l
         6KG4z4opT2+dGHJ2ATrLJIGxmdfJWYMBiBgo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sl5BaP2iiNhbnj4MS/VHo6ECSBx8gzfpa849w91l1Wmb8MPr1kmd1cAENc4nwA695a
         5z5r1FXsWt9fHg48bh5ICNonfFH0Ud08BxZQyljKNwT8RZ4g5Y26atBA8BiCrXgqmGCX
         zEy5mC3d8xv8xwJ9jpvS59J0DJb0qFBC/1ERY=
Received: by 10.229.231.3 with SMTP id jo3mr6859483qcb.21.1286923872172;
        Tue, 12 Oct 2010 15:51:12 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id nb14sm6695344qcb.24.2010.10.12.15.51.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 15:51:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286891424-2067-4-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158889>

David Barr wrote:

> While at it, fix a typo in an error message: the cat command is used
> to examine paths within trees, not branches.

If we need the cat <tree> "<path>" functionality, probably this part
should be squashed with the previous one.
