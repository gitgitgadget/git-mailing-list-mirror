From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 23 Jul 2008 23:33:36 +0400
Message-ID: <37fcd2780807231233o6e71303doeea53c8f4e5aab67@mail.gmail.com>
References: <alpine.DEB.1.00.0807222255450.8986@racer>
	 <7vy73tihl6.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807230203350.8986@racer>
	 <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807231817460.8986@racer>
	 <488772BC.80207@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Joshua Jensen" <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:34:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLk6i-0003uq-1I
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYGWTdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbYGWTdj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:33:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:2261 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbYGWTdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:33:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1116719ywe.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lD03eCmQgiBXf60ZRxVs2nsXRVfw32YalaeDYKsjeRA=;
        b=SoNI4KHxx+pXJVG1MpmkOjt66VceM5GzB+E4E1vUOvu1BGuf0O5HaAZP3ZRw7NPRLm
         zVGSbB0YiV52X1wnltbMcLMBVI1UXcYrbcQcdoyiJs6Y7hOpiMA5EGz03uL1oBhwl5wS
         WvYtGJhMrgIdAD5fP1af9po6OWfVpszNWf/kU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QGe1RBBCu3O1kLzAhLZuav0bjM/Hgrq+hVZvyqIE2ZrBbX6qR8+NCvyuldL2tFjK8z
         YgxYpE3h5Edoe7ZY2E5JwMAmXPJ3+ooJCDxbCyEcjt5pTIKgivormBuDo8Q3x0qV6rXK
         xqqIgPOrSCHxVhPxmATECpaqwdJ3MM78Vtens=
Received: by 10.142.164.10 with SMTP id m10mr63121wfe.60.1216841616167;
        Wed, 23 Jul 2008 12:33:36 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Wed, 23 Jul 2008 12:33:36 -0700 (PDT)
In-Reply-To: <488772BC.80207@workspacewhiz.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89753>

On Wed, Jul 23, 2008 at 10:04 PM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
>
> There are certain file formats, such as a Visual Studio .sln file, that MUST
> be CRLF.  When a .sln file is not CRLF, Visual Studio refuses to read it.

I wonder what exactly version of Visual Studio you use? All version that
I have seen had no problem reading .sln with LF ending, though they always
wrote it back with CRLF. In any case, you can define as binary, so Git will
not do anything about their EOLs.

Dmitry
