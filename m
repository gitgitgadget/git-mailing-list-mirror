From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: TopGit: problem with patch series generation
Date: Tue, 12 Aug 2008 12:25:36 -0400
Message-ID: <32541b130808120925y663967ebm38eced6df77ffe4@mail.gmail.com>
References: <20080812161854.GB30067@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git discussion list" <git@vger.kernel.org>, pasky@suse.cz,
	"Manoj Srivastava" <srivasta@debian.org>,
	"vcs distro packaging discussion list" 
	<vcs-pkg-discuss@lists.alioth.debian.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 18:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSwhl-0006V4-58
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 18:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbYHLQZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 12:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbYHLQZi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 12:25:38 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:23797 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbYHLQZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 12:25:37 -0400
Received: by qw-out-2122.google.com with SMTP id 3so227358qwe.37
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5pXthRKw41gaqxOtc+V8bOpAS3hjqV/sMDel7vAWr3g=;
        b=o9wayX1BZBiX5PHaFfp9NLIfVWeQSlRgfsKISH5IUT88OUSTD7ROfawh9eKWR8Sdi7
         F6NYspxLzp+qr/91g4Jzd0mf/1zXZJIDYGJS+/pZQ0dgd7J1phnYI/u+Qx/EcJ6JNm+v
         YI6SHT6Qja/kYLvt9lpGUUXB+OiYrWffWRNt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nZ1A78tNoAzdeJoJGt127Kpo9EODJnBMfmJPwQXbaXwUlfyBtZOrRXoNjiMDouu1od
         2uABqDCAyZrpk1O3vKN23IuiD0t/0B8P73DKcMeFiPmIgM4n60L7VryBjbhlbp17dyBM
         yQFeJfNunujWLuhSNf1thoLWW9gd+AEIqocuI=
Received: by 10.151.153.19 with SMTP id f19mr14626367ybo.116.1218558336477;
        Tue, 12 Aug 2008 09:25:36 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Tue, 12 Aug 2008 09:25:36 -0700 (PDT)
In-Reply-To: <20080812161854.GB30067@lapse.rw.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92111>

On Tue, Aug 12, 2008 at 12:18 PM, martin f krafft <madduck@debian.org> wrote:
> As I am packaging TopGit for Debian, I encountered
> the situation that two branches conflict with each other (they
> change the same line), but there is no dependency between the
> branches. Thus, when I squash the branches into a series, the
> resulting patches will not apply (they both change the same original
> line to something else).

Isn't this what git-rerere is for?  If TopGit doesn't use rerere,
maybe it would be easy to add...

Have fun,

Avery
