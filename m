From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git push
Date: Wed, 25 Feb 2009 04:34:54 -0500
Message-ID: <76718490902250134q580caaffuf5f13d87e3d0974c@mail.gmail.com>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
	 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
	 <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:36:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGBl-0003h9-Po
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbZBYJe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbZBYJe4
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:34:56 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:26950 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbZBYJez (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:34:55 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2937765rvb.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 01:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uLI+ySRzonXXy3sJlzGsWTOcVw+2DXwUqxPAX6c0ezU=;
        b=hd25DlVORBzvqJ4nSqcs1dfTHPBc9LQn7+IZy21HfK26bErisQiJlksx1ZQFJ2oiFG
         egBpjN1Me4T9Dtp5v4VhB4tl92gxPXEt+rgGq4XU/2DCSI/4yntjQK81lx/4EJEIYx20
         kQtzSRjNPYH/m0Enh/xyWFHdNebqsnPUfBOgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xeFLZomO+bohLn8UkSns2p+oiSawz4dDH/1pH49S8zHNjcl9RgPVAWVocQUfnoa79J
         jSSFGCr7XF1pN2eriwgzG1X7vCbJ2E8G/dRuv90u7K5yEQbEB2GXiePGxl9LWkFn5/g1
         wpKQ1XQKeAizJW/sqyI9vGzHeHtJu3IGV1V40=
Received: by 10.141.29.14 with SMTP id g14mr3107924rvj.232.1235554494320; Wed, 
	25 Feb 2009 01:34:54 -0800 (PST)
In-Reply-To: <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111421>

On Wed, Feb 25, 2009 at 2:44 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Oh, and the value 'current' can be spelled as 'HEAD' already there.

John - in case you missed this, the behavior you desire is already available:

(next)$ git config remote.origin.push HEAD
(next)$ git remote show origin
  [...]
  Local ref configured for 'git push':
    HEAD pushes to next (fast forwardable)
(next)$ git checkout master

(master)$ git remote show origin
  [...]
  Local ref configured for 'git push':
    HEAD pushes to master (fast forwardable)

j.
