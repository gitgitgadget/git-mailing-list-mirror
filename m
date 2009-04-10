From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: [FR] Encrypting the repository
Date: Fri, 10 Apr 2009 03:18:59 -0700
Message-ID: <83d7aaa40904100318k5aa779c4h95cd01727eafbb35@mail.gmail.com>
References: <loom.20090410T084314-918@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 12:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsDqc-0007j5-UB
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 12:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbZDJKTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 06:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767AbZDJKTA
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 06:19:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:23611 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZDJKTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 06:19:00 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1014984rvb.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=CCExFXLkrWFYcCJIeiK72QvJacnTj/SYMrH0OZA3Vjw=;
        b=xuBC3jddvEdB4VsAod7dKP8cADdJbDlQ2pFzSckJYXUY/DR20D89L82mdwtwsSiCY2
         K5+6ZsDP87c9CFRz7FpG66YZVttQPC+4YGD5Jeu/zScwvXhGdS/Lg9dJ5G+K9XSNcT+5
         q2mHu1OLeTrAVPfyUbba7eEZRFOSajTvjmt04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=kUf3Aeya4jGRiXQJyL6KaLniSNv1cvb121dvtS3tNSy+bborVevjChMdVgybh34du3
         m4jZo8PcDajCs6TQKIeqFoHukLHBtJOEVUcOBY3g+3FTL6fVrcPOwhCykkAUMik8ieJm
         MTvHk4hZBDjxfZ04gUm0oVtbE3aymUnVPu4c0=
Received: by 10.142.133.19 with SMTP id g19mr1268022wfd.116.1239358739225; 
	Fri, 10 Apr 2009 03:18:59 -0700 (PDT)
In-Reply-To: <loom.20090410T084314-918@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116250>

On Fri, Apr 10, 2009 at 1:49 AM, Aaron Digulla <digulla@hepe.com> wrote:
> I need a way to safely synchronize data between several places using an unsafe
> storage (USB stick, Internet drive). So my question is: How much work would it
> be to patch GIT to encrypt all files in the repository using AES-256?

Why in the world would you want to modify Git to do that? Just use an
existing encryption solution. If you need to use a USB drive, then use
disk encryption. If you need to do it online, then use SSH.
http://www.dmoz.org/Computers/Security/Products_and_Tools/Cryptography/

-Geoffrey Lee
