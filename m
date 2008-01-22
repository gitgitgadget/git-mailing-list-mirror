From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: Using email between 2 developers to keep git repositories in sync
Date: Tue, 22 Jan 2008 09:35:12 -0500
Message-ID: <30e4a070801220635q4978fd2fvc469ca00af4e11cc@mail.gmail.com>
References: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com>
	 <alpine.LSU.1.00.0801221255530.5731@racer.site>
	 <m3k5m2klmh.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	ab_lists@mac.com, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 15:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHKED-00028m-Nn
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 15:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYAVOfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 09:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbYAVOfS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 09:35:18 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:11159 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752051AbYAVOfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 09:35:16 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2146549hsz.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0S9ISs5t2uhSVosQKtqsakU6rCNh2bBfylD+BSslMAs=;
        b=VI0/SoagbZoQypyKMKGIqSwMTmGxBOoA/tjEGSvTl5v9ECsaIgf9l4CBEMSov037wmx/+qJ3PwNyJ6nZb6mxocB6/uzzOyqmcC9xy1KuyrsNIhlFM0vswFvew3yXx6JyFbwwpAO97ZYAhkPQcCku+O8YQo09i7sz4yUHzrT1C40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=InyTpWIkpt+of9hWWR3/tn0xxpIVYhn5wi3qjm7uMVRxVW/rzYyHe+w0vQKbkEym2FzqP/CTCZgaagBx8USw7dyum9kni4h22Ex1ttDr/XSskYmyyKUlYFb5rxcgv4mGJJwp1Q3gYWkQexV09DIx9P5HnzXIKByaNfZtx4RxkWk=
Received: by 10.142.79.15 with SMTP id c15mr4043137wfb.105.1201012512348;
        Tue, 22 Jan 2008 06:35:12 -0800 (PST)
Received: by 10.143.15.6 with HTTP; Tue, 22 Jan 2008 06:35:12 -0800 (PST)
In-Reply-To: <m3k5m2klmh.fsf@roke.D-201>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71453>

On Jan 22, 2008 8:53 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> Besides, after initial setup IMHO it is much better to exchange
> patches for review. Although usually there are more than two
> developers in such case...
>
Bundles allow you to maintain identical history on two or more
disconnected servers, and this is a very distinct advantage over
patches. Absent use of bundles to distribute the integrated changes,
the development history seen by both parties will diverge.

Mark
