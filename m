From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/3] push: add --current
Date: Mon, 20 Jul 2009 18:15:32 +0800
Message-ID: <be6fef0d0907200315j14089edcv8baa997d2ec34f3f@mail.gmail.com>
References: <1248071820-18289-1-git-send-email-bonzini@gnu.org>
	 <1248071820-18289-3-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 12:21:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSq0F-0003lS-PB
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 12:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbZGTKVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 06:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbZGTKVj
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 06:21:39 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10446 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbZGTKVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 06:21:38 -0400
Received: by wf-out-1314.google.com with SMTP id 26so702424wfd.4
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CnuVObDQYNmoktUJ8uxJielUWS7OO7TbUfeFZNFcZfs=;
        b=fZPzPfTxekIVmM8yFrN6ucezMKGN2Y4n2xjSoPF33vx8ZOfX1Y56+faWHoFif7tPyD
         jiU4LHLLO55r7CUfSms1NSm6c8OKZzxK1v960Yf9jMDuG48Quy9s2Bkm9/sGDcdogx7Z
         m265Qr4/nJORHWYd3WJxmq+bsfWjDz1atGLnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pnSlYBLO9fhtaNJWhOZDa7pvnNSHNEhPBWilwNyrgfgeJ4kq+nuct+K3jipr1CeCkF
         xaLTs5lsW0xZA9aQ2qa4tws0JVq/6BQLcHfE8ae18K/fgh/aGsCU8xxKqZEILZa+lz+P
         LrINikGtd0SNTGPPvkK4A4jd9OGmaz23wM8oA=
Received: by 10.142.241.15 with SMTP id o15mr1086921wfh.264.1248084932464; 
	Mon, 20 Jul 2009 03:15:32 -0700 (PDT)
In-Reply-To: <1248071820-18289-3-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123584>

Hi,

On Mon, Jul 20, 2009 at 2:36 PM, Paolo Bonzini<bonzini@gnu.org> wrote:
> =A0t/t5516-fetch-push.sh =A0 =A0 =A0| =A0 50 ++++++++++++++++++++++++=
++++++++++++++++++++

since you're making modifications to pushing over HTTP, you should
consider making tests also for HTTP repositories, or else your changes
in http-push.c won't be used.

--=20
Cheers,
Ray Chuan
