From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: egit and RSA keys for SSH
Date: Mon, 15 Jun 2009 22:27:42 +0800
Message-ID: <be6fef0d0906150727i2f57318dq9dc9b1a3d1208196@mail.gmail.com>
References: <F2969C1B08CBEE42B78C04C280D578E72CAF41E19B@donkey.landcare.ad.landcareresearch.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Aaron Hicks <HicksA@landcareresearch.co.nz>
X-From: git-owner@vger.kernel.org Mon Jun 15 16:27:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGDA6-0006Vg-6y
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 16:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155AbZFOO1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 10:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbZFOO1k
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 10:27:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:2478 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbZFOO1j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 10:27:39 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1492619wfd.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FENOH7bYh9P87FY5OfqkfxHknCZO+FdvL5cGn/+Vc/Q=;
        b=hb0314ZaASWwR1kSQf+5hYp+pla61m07ZpbQ50Q6yMXTDF0bcLVytEQgwgpoRa7tNB
         Q0+Qfv9vKP+PhsrFPuTlMY28FDxT+9UOGXUVdX9JhYGs0cWBbGMl8zzsT06kAcs/Zk85
         CCVd9tPN7BR7SdI2NW2KhzhJPWviPZtRxmmvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IalAnEO81wPzebc/fqL7OSDTztADgrlraZ1hOBExthbl2mpWGbNaE7tjXzZK3pK1QT
         1ji6BY/FHKAjk1tjIn5GzQSp/Joe9SGmSLf5/Fdqvv7gZwqxIMdRLBnTsSY1xw3eez1X
         Ke71Fome8M/vBw1iD368sJmYxjeMqp1q+RTBA=
Received: by 10.142.180.10 with SMTP id c10mr3117230wff.17.1245076062302; Mon, 
	15 Jun 2009 07:27:42 -0700 (PDT)
In-Reply-To: <F2969C1B08CBEE42B78C04C280D578E72CAF41E19B@donkey.landcare.ad.landcareresearch.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121609>

Hi,

On Mon, Jun 15, 2009 at 8:16 AM, Aaron
Hicks<HicksA@landcareresearch.co.nz> wrote:
> The problem is I can't see how to associate an RSA key in order to authenticate the SSH login with our gitosis repository (or GitHub). We have PuTTY installed and use Pageant to manage keys, and the required key is already loaded. We've used the 'import project' wizard, and initialised git in our project workspace, and though egit becomes aware that the project is a git repository, there seem to be no menu items for associating an RSA key with a remote repository.

For git, I set the GIT_SSH environment variable to PuTTY's plink.exe
location. I wonder if this might work with egit?

-- 
Cheers,
Ray Chuan
