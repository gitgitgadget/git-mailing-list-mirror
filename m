From: Ping Yin <pkufranky@gmail.com>
Subject: Any easy way to represent the first commit in a branch?
Date: Sat, 29 May 2010 11:36:55 +0800
Message-ID: <AANLkTinU1dMd1mA2mpoO0rB9OaOofuekPFSCFoFd2Bf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 29 05:37:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OICrM-0001bb-IV
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 05:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141Ab0E2Dg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 23:36:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35657 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085Ab0E2Dg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 23:36:56 -0400
Received: by vws9 with SMTP id 9so1871104vws.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 20:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=4zrtH5vcVHOEZnaDNfHqVS0IygfPTBLa26o92dC1OFg=;
        b=Oj2KAjLR0U42IAxlLpYER8uvUMMKuUTEYl1qqQy+7jd/VYqcPS6XjdSU65x0YYi3hl
         28v3+b3/cteKUhTM4LgpqbA0jPzhU1IDSVfgK4UXznVPBAr5GpzQHEAiFAnpSLMvyMx5
         oiQSyaBHbr7ie9qxb5EO/YV2DbQfLimHX3WBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=gYFneP/IhQxQ0qZgNlwQRFcOevRtMrHXjWVZaLV7dJegTrb5twJ5izlx+9kCU1DvcN
         Mrywj9ftUAIq33cAj8M/EPXWQd7/koj0ix7S/nh7QhC3MfvIN9E0cKOjjn1brLZo51KT
         lIruDbh+7DVIAabultYiJIssEzUGJS8IlALg0=
Received: by 10.224.44.206 with SMTP id b14mr668991qaf.256.1275104215723; Fri, 
	28 May 2010 20:36:55 -0700 (PDT)
Received: by 10.229.83.145 with HTTP; Fri, 28 May 2010 20:36:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147950>

something like HEAD@root ?

I know i can do it with

git rev-list --reverse --first-parent HEAD | head -1
