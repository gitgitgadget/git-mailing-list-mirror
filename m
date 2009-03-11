From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Include log_config module in apache.conf
Date: Wed, 11 Mar 2009 18:43:12 -0400
Message-ID: <76718490903111543n33179571r2b3498f1f4ecacf3@mail.gmail.com>
References: <alpine.LNX.1.00.0903102320170.19665@iabervon.org>
	 <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de>
	 <7vab7r6g59.fsf@gitster.siamese.dyndns.org>
	 <E7E9DDFD-F8F6-4B39-A3E3-48CC1C8F5BBC@silverinsanity.com>
	 <7vhc1z4y31.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:52:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhXAL-0001H6-9S
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 23:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbZCKWnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 18:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbZCKWnP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 18:43:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:32702 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbZCKWnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 18:43:14 -0400
Received: by rv-out-0506.google.com with SMTP id g9so3287149rvb.5
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f8ZnRMSQ9v40DrGb5BmTIq9l93Y3msyPFYZiO7y2+dU=;
        b=nn2KYVsQ4rP8seXW0UWqqzHCHtd9BWnMD2TFmIehXXh9x9BCZH5Da+FzYeFO5E4kgZ
         YJLqoZudl3g3KYZUhVhc/EPyajNFT0MOTca59cRqhfixDvz15Pfn76YktvNeFfyvVxgu
         1KumkQkCv028Swz5yrdYEJ6lrxgTRnrXTZDFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IyJMmfB2HYjIdJe0uvkE7i0wfqsOwUy4Bxxgp1R1v2VDMWg388t8GuNPO8GRGZFTYi
         SWQXwpqzzrziggYo2tzgty6uJ0SjViai0AJ8GvXfhlEBltWbNZLcGF5zl7wxEZUOcxbL
         ckgbTuA/EK2TIyXlJfwsVnd1KsnRDm7et0p0k=
Received: by 10.141.142.1 with SMTP id u1mr4630248rvn.93.1236811392500; Wed, 
	11 Mar 2009 15:43:12 -0700 (PDT)
In-Reply-To: <7vhc1z4y31.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112988>

On Wed, Mar 11, 2009 at 4:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> We have PidFile definition in the file already, and we have added
> necessary LoadModule for log_config_module recently.
>
> This patch will end up giving LockFile to everybody not just limited to
> Darwin, but why not?

In that case, the -DDarwin added to lib-httpd.sh by commit 69707d61 is
no longer needed.

j.
