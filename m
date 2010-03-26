From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Deleting remote branches
Date: Fri, 26 Mar 2010 08:52:32 -0700
Message-ID: <a038bef51003260852x204500fv8db7dd7a42516050@mail.gmail.com>
References: <1269582415273-4802262.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 16:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBpy-0005o9-MM
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab0CZPwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 11:52:34 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:37460 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0CZPwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 11:52:33 -0400
Received: by qyk26 with SMTP id 26so6609153qyk.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P+62+rkMYtlQPPRqIDiRJN26EAgeIzOdLiDxx69gzgI=;
        b=spTsKx7lpWykJ9Tn87OimTd23lDOeYQKOnuN8xHzYQLLIBb692ZvR6pX6jp4vlmmmj
         IetK2Fsf8lXflbpclvmxrU+ptl4LNRPrQDFOS25CpTaUwb2huAlw8zWxYxD5aYDSkGE5
         dn/rSvqrY2a4de5E6q4O+4ObDr1/qZtbQhl9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ahL0plOel3K+aM43iPMN/D6RNgmuvNQwb+D15fqAz32uU1/+7NoMGhx2Q4Xgz9Vwdc
         VEcUCmxBJdkdTHCL9lk6z1ohWYWOasV5rt6lYpX4Ltb2DugC3fKwbIl+KnTcmbMmeX+O
         6HBSKEAU/Vyq2cW4Rg3ds7hZ+sp44tkjYQd7c=
Received: by 10.229.27.141 with HTTP; Fri, 26 Mar 2010 08:52:32 -0700 (PDT)
In-Reply-To: <1269582415273-4802262.post@n2.nabble.com>
Received: by 10.229.96.82 with SMTP id g18mr1418612qcn.82.1269618752653; Fri, 
	26 Mar 2010 08:52:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143253>

On Thu, Mar 25, 2010 at 10:46 PM, jhapk <pradeep.kumar.jha@gmail.com> w=
rote:
>
> Hi,
>
> =C2=A0jeff
> =C2=A0master
> * work
> =C2=A0origin/HEAD
> =C2=A0origin/RANSmodel
> =C2=A0origin/bluffbody
> =C2=A0origin/counterflow
> =C2=A0origin/flamelet
> =C2=A0origin/jeff
> =C2=A0origin/master
> =C2=A0origin/test
> =C2=A0origin/work
> I still get all these branches which I deleted in my remote 'origin'.
>

'git remote prune origin' will clean up the references you have to
branches that no longer exist in origin
