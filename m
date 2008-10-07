From: "J.R. Mauro" <jrm8005@gmail.com>
Subject: Git pager woes
Date: Tue, 7 Oct 2008 09:43:12 -0400
Message-ID: <3aaafc130810070643m352ea2ufa1069dc149f0d9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 15:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnCrT-0006j9-PW
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 15:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbYJGNnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbYJGNnO
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 09:43:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:58141 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbYJGNnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 09:43:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3573579rvb.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ZIiRzt2CAAfHVum4SSTwHLF/OfpQ+Vw1TO72hqKTDHo=;
        b=vLKZRdRq7d9Bjpkn9+W8+xVFzwcgtuPf0UR9R+b9Vjnr4zqCey0m41tSO9x9DQebUd
         qAVS3O7ronbLFzExfykigopxN8SLQOcNXsP8Cgc6kqmEVoE/rxjtbkRyTswF1jym9Qh8
         8lDznjpGKK6TcdfDzkW/Na5Gwy5GEvZEhjkVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=GFNJ43frr7nK2+FDVHxoj9LqDvE+/tSyNsDCzdKeKwxw9ZaP9euwgEFF+lX543wY/Y
         I5gBX9hj2gCAB/LRX6h63GsY/fVyri5/9Jj7Oe++5yqo8z7qp8Lhg3nn3LnbIcQWITWI
         ZaBmfnQ4+9kfm9KYUvyt0+Dw1FZ6bYA35vGdU=
Received: by 10.141.66.16 with SMTP id t16mr3874600rvk.168.1223386992828;
        Tue, 07 Oct 2008 06:43:12 -0700 (PDT)
Received: by 10.141.201.20 with HTTP; Tue, 7 Oct 2008 06:43:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97705>

Git doesn't set special options to it's pager command if the LESS
environment variable is set. I noticed when I started using Gentoo
that git was putting all output into a pager even if it were less than
one page, which it didn't do under Ubuntu. A fellow Gentoo user
confirms this; apparently Gentoo's defaults set LESS, but without a
-F.

Should git always tack on a -F when it invokes less, or should this be
put on the user to look up what to do? Or should I go complain to the
Gentoo folks?
