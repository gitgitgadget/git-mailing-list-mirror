From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Tue, 19 Aug 2008 20:46:44 +0700
Message-ID: <fcaeb9bf0808190646m6304b2cboa7af1d5de5e0f8d1@mail.gmail.com>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
	 <20080819132803.GA26201@laptop> <vpqej4lcem2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVRYx-0000t4-IS
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYHSNqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 09:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYHSNqq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:46:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:38763 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbYHSNqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:46:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so8929fgg.17
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Pp8uR++f4f5fZBjB6jPAYawsXFk4bd4MwtFfjIf7v7s=;
        b=qpX/H7owjUaD++VtObLv7Y8EnDCAs2d8IopRRJPOb9ylLHHt0UIpD8yfE+23ihMSDo
         1cqP/MniAF09Nq1MaFdvaOW5zIeDgxs8GjUeaU6iBgZRFJ9ULKQV66vpDc/mj2pHd/oX
         J3aF/1rpBw00k7Sof1ZieYiqCexXlDNMdpsvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=moYPXzbhUqufpfsprixaRFUUv6RJKh9eeq1D2nSwVv+/ZtlzW+UYYu6ymZff1fuNlc
         0yOrqdU0PMN7fTGZ142e5wtU13KsV97atESZndDxTid/sK2HVMKVDv5jtCYSNlNws3BK
         8Vlud25P6V4YVpUJ9+U1FyqRL4mVSoFY/Zn4Q=
Received: by 10.86.72.15 with SMTP id u15mr5626775fga.22.1219153604226;
        Tue, 19 Aug 2008 06:46:44 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Tue, 19 Aug 2008 06:46:44 -0700 (PDT)
In-Reply-To: <vpqej4lcem2.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92860>

On 8/19/08, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>  > Bash completion needs to know what strategies git supports. Maybe
>  > other similar tools have the same demand. So add
>  > "git merge--show-strategies"
>
>             ^^
>
>  Silly detail, but a space is missing here.

Yes, my poor eyes. Junio if you accept the patch, please add one more
space. Thanks :)

-- 
Duy
