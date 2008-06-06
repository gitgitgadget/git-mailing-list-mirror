From: "Cedric Vivier" <cedricv@neonux.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 6 Jun 2008 23:17:30 +0200
Message-ID: <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
	 <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>
	 <alpine.DEB.1.00.0806061911300.1783@racer>
	 <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4jKN-000357-Bm
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 23:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbYFFVRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 17:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932988AbYFFVRc
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 17:17:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:33610 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932604AbYFFVRb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 17:17:31 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1702874rvb.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=sw8eIsxKJaQfQIurUmiJMjQf6p3cHRmqR9qrwcP+QBk=;
        b=GX1pdcJUQKhUcuKVaAi9Tvp1rsqd8frtfipHWdKA20dnrU96ZoidYqU0AAlYRckngY
         dhobuy0dI43KyMyFIkFRfyFu89bvPTbNwG0tT0OMFgPqYscCFMyFlSNF/Q0aCXYtSwpf
         3R8KM+ROnKkr9d7iHvvOJ/vB9AZPShAKe43Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=pioSlv6Ab+HqWyviWOxQcWytCo2sfRm5L2fHf5xHM6UcFHsSBiUvjWRIyifO71v9Ai
         sVEuJbxoMwA8koJhCNmPFq/gOD/3nQkM9DEEUp58Ed8UMRw+TuzWNBpF/S63VSJnOBQd
         VYqqFaPrvCWOKNtfMTqCaaIOtVt0R6Zrbk+0Q=
Received: by 10.114.201.1 with SMTP id y1mr753673waf.216.1212787050072;
        Fri, 06 Jun 2008 14:17:30 -0700 (PDT)
Received: by 10.115.33.3 with HTTP; Fri, 6 Jun 2008 14:17:30 -0700 (PDT)
In-Reply-To: <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil>
Content-Disposition: inline
X-Google-Sender-Auth: 543a82c2e149b708
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84117>

On Fri, Jun 6, 2008 at 11:04 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> But can't that be just as easily done by piping through sort? (I understand
> there is a platform which lacks the sort utility, boohoo)

Yes, but sort does not have a natural sort option afaik.
If natural sort is the default order though then piping through sort
to get things in "non-natural" order is easy enough indeed.
