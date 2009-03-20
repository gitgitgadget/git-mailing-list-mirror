From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git-push on packed refs via HTTP
Date: Fri, 20 Mar 2009 20:00:32 +0800
Message-ID: <be6fef0d0903200500u4d26d00fm653bc1e708a0c26b@mail.gmail.com>
References: <loom.20090320T094550-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steve <shrotty@gmx.ch>
X-From: git-owner@vger.kernel.org Fri Mar 20 13:05:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkdSm-0006pW-3q
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 13:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759517AbZCTMAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 08:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757055AbZCTMAf
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 08:00:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:15024 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZCTMAe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 08:00:34 -0400
Received: by rv-out-0506.google.com with SMTP id g37so325001rvb.5
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9flqOmHiCR5IwqaUMJJUOD7cpkQo5oJmZs3SVk+vzEA=;
        b=vDOp3WM6wBo4U8iPSWcAv8OfPhwA2s/l/6uctb3k6AnlS+T0gAJRI6QO9S0muZ5LHW
         QZs0bcEriU63CvT8aUQUR8nbErobS2IaldLJ6BelRPK20WaFh5k27c6LJhbyhkMVuagC
         fkw6d+cyTlC41hXDxcHlq20vZb8cW9qCiKKQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u7i79VHuRr4h5q+2JnVp5D6j6j/S0UgAeDvWEPGp1fufUlEdPIO/TdrwV03OBWm7iL
         rGSR9+DYNB25dtXf07GPexuYxs3dfIiFoJQZTj0pyIITF6dKamatu10m/RrZjXoujija
         LTJnBik40dzYq4UrntMug/eU0nrVaUmMPFZpk=
Received: by 10.114.74.18 with SMTP id w18mr2421612waa.40.1237550432328; Fri, 
	20 Mar 2009 05:00:32 -0700 (PDT)
In-Reply-To: <loom.20090320T094550-421@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113946>

Hi,

On Fri, Mar 20, 2009 at 5:50 PM, Steve <shrotty@gmx.ch> wrote:
> Using HTTP as transport, I've noticed that after using git-gc on a git server, I
> can't push to that repo anymore: "No refs in common and none specified." Client
> and server are both 1.6.2. Is ths a bug or do I have to do something after
> executing git-gc on the server?

could you try running git update-server-info?

-- 
Cheers,
Ray Chuan
