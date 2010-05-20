From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Revision Generation Question
Date: Thu, 20 May 2010 13:34:09 +0200
Message-ID: <AANLkTimg2zxwI2LC97sNyRpa8zChSUPeWCU-zr1DLbuK@mail.gmail.com>
References: <000d01caf7f0$7f8c6700$7ea53500$@anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Albert Krawczyk <u4232169@anu.edu.au>
X-From: git-owner@vger.kernel.org Thu May 20 13:34:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF41N-0008JS-RG
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 13:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648Ab0ETLec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 07:34:32 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:43636 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0ETLeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 07:34:31 -0400
Received: by qyk1 with SMTP id 1so11887878qyk.5
        for <git@vger.kernel.org>; Thu, 20 May 2010 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=fQO/qvLCveFZ5cCsnQ7iRZW+jXZmnQIMNVbjavHvCck=;
        b=Fii2+OiztlOrLv52ti4XaopLApCA/XphpuIZepBvWzi2Lv4vbThBoCZxusIYJNo3ks
         KSBLwysWnAoqO9NNTKUqi7my9E5QsTrOFAx8ovGDcUQS7YNoBoJhsYl/F/mRdhx7kTnZ
         GABbmHAgQpLJOmWO/LWiuXiQxjXs8646Jugug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=g3sOli8yFCx+ZB1wrJ9y6fZF3ZmR6pN7SxXBMBHMwr7fvGhbXFgLyShaRlQuPtb2dz
         hLxM3ObQNAc19KiCK2X6/9cQ7J7EgIQTfPnv5i1aSBpMlpAWXgXnmJqiOPdwSkx48Amh
         MUKfQCLKBZR0EMhpZkrtSBgpCQycxZWKzgyEI=
Received: by 10.229.226.135 with SMTP id iw7mr2144412qcb.63.1274355269164; 
	Thu, 20 May 2010 04:34:29 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Thu, 20 May 2010 04:34:09 -0700 (PDT)
In-Reply-To: <000d01caf7f0$7f8c6700$7ea53500$@anu.edu.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147382>

Hi,

On Thu, May 20, 2010 at 9:46 AM, Albert Krawczyk <u4232169@anu.edu.au> wrote:
> I'm trying to figure out how the internal revision generation works. Could
> somebody shed some light on how this happens in the code?

In short, there are four kinds of objects that Git uses internally:
commit, blob, tree and tag. It can compress objects into a packfile
for minimizing storage space. I recommend chapter 9 of the Pro Git
book for more [1].

-- Ram

[1] http://progit.org/book/ch9-0.html
