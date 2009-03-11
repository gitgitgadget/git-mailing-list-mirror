From: David Symonds <dsymonds@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 19:59:03 +1100
Message-ID: <ee77f5c20903110159l1cda4c3dnc9588c1352905932@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Saurabh Gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 10:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhKIn-0002m7-46
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 10:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbZCKI7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 04:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbZCKI7H
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 04:59:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:14466 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbZCKI7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 04:59:05 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3108123wfa.4
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=10EiLxvPEdL4KJGR3/Id7Y0Ckz8DMw+6i+oyMR4R9IM=;
        b=wrgIvNpRVCYelgL4dx+LogZ02vlMfR4DWEqfcWWPYjpXFPpCX5RAufMqwE6JjezYIH
         IHQOXTAk+vJWZFOPEPNufhIIAHoxtlEJTDNM2fMApcaPo32dnbUWUcVgpGC78NCpcKyr
         YS31rmppNNfJ9ytrNo1YeF4ei3cgGDruW+Oxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SMhPqjojBClzhP1PyRY4vTvAtWm82ZeGooB9brYjAR+pEtb6DgwntVY/VpS0+9jGks
         pCObB1FAA1yPcFI3LIAoVQ3U7C77z44BIJ6lA9C14jyqLE7WHvC/hMKvnqVXbpMk3gql
         TQn7mVdpJdDlZQUV5ez7Hj4rwMIPk0Jm6eBvI=
Received: by 10.142.230.11 with SMTP id c11mr3571384wfh.305.1236761943334; 
	Wed, 11 Mar 2009 01:59:03 -0700 (PDT)
In-Reply-To: <49B74373.3090609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112893>

On Wed, Mar 11, 2009 at 3:52 PM, Saurabh Gupta
<saurabhgupta1403@gmail.com> wrote:

> *1) Domain specific merge helpers*
> Intelligence in the merger can be put which modifies the source file
> according the format. Different file formats can be put in the merger
> to support.

I don't think that's Git specific, though it still might be reasonable
to be done as a Git GSoC project. I'm sure other VCSs would find that
useful, and even folk who aren't using VCSs might benefit from it.


Dave.
