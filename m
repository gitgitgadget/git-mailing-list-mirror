From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 14:20:59 -0600
Message-ID: <51419b2c0809091320jaf66a20y46b78972130af58d@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Govind Salinas" <govind@sophiasuchtig.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd9jG-0003NT-T3
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbYIIUVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbYIIUVT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:21:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:62438 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbYIIUVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:21:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2048655rvb.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6FFAidiTDTJcZG7xWth8oKhAeN0QS6RsKDRfUXWiiVA=;
        b=r/BRSxZFnEnFaRY8pOKCjT6qN6QVpXTzD9vSTvWeid2zyj+lTO7DnlzAwskt8sceWD
         nI/GjRc1VO6K0Nesa4dq5r1HQ6YY3EoiqLmL9765NMZFsidtpKzn44PXqBvYr144yiuk
         2WzifDvVqkPDESuGQ3xUSV3viRzml3TuZHDAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rteqJoeJePW7guBruNxFjdRleBJN3YQeFLvTZbX7Kvl5c6w+qaceIWtswYr/vbscmY
         kOxl/A+t1d0N+3CsxEtylRS0cQfXLyErM/JrQM6bmzUo0lJ3o7aUhbg9biDt3SVqz/gI
         5NDFI6T2yZiZV2qTCSYJv53IBKLEwjL3CXzV0=
Received: by 10.141.198.9 with SMTP id a9mr127248rvq.108.1220991671487;
        Tue, 09 Sep 2008 13:21:11 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Tue, 9 Sep 2008 13:20:59 -0700 (PDT)
In-Reply-To: <200809091538.13961.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95424>

On Tue, Sep 9, 2008 at 7:38 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> By the way, I think the fact that in different SCMs meaning of
> "$scm revert" and of "$scm reset" differs widely caused Mercurial
> to adopt "hg backout" for creating a commit which reverts changes
> (cherry-pick -R), and "hg rollback" to undo last commit.

Ah, I had somehow missed hg backout.  Thanks for the pointer!

Elijah
