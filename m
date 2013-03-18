From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [ITCH] Specify refspec without remote
Date: Mon, 18 Mar 2013 22:28:59 +0530
Message-ID: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 17:59:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHdPX-00071O-Hb
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 17:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab3CRQ7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 12:59:20 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:58729 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3CRQ7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 12:59:20 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so1756395iag.27
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=QVG6h/LEJMhGcZg+OIg9RMOWH1UVNgahRdZ2edi2Y60=;
        b=b4gUoQBnygTg97ar0kVCleFXklML5qLIY/Vf6dCVq/OSWBepe6W50bThfjhl2xh5KC
         po6vNYgGCPOIaoAHJkxWi2erikFFxwKPVkJT6SQkjzvis9l4FhI6V7u2xBo/3SKiwGwi
         MhKgNCYOWqoSLvo4zoS/NksQnMK89q4H+LR8UBdDi96BL2nhVAK66yArojJ4WqlqmzDJ
         uMpUXBkpQT/ihNBCs62q34SZhd9ojMkE1gN02iYLPTrjZne8seE0ZyuxJSeN6Rx6kd9r
         /PyJSbMo+WWg+Kww63MAmLLU3ZLbFk2jZF8P+Z9+G+dqVPERSydSwujGlfn4T6zyJwBM
         9eEA==
X-Received: by 10.50.17.71 with SMTP id m7mr6390701igd.14.1363625959745; Mon,
 18 Mar 2013 09:59:19 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 18 Mar 2013 09:58:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218429>

Hi,

This has irritated me for a long time.  I often end up doing:

    $ git push master:master +pu:pu

only to get an error, because I have to specify the remote before
specifying the refspec.  I find this ugly because I rarely want to
push to a remote that is different from the one configured, but often
want to specify my own refspec (say which branches to push, force
push).  Ofcourse, the same is the case while fetching.

Is there a reason for the remote not being optional, or are we just
waiting for a patch?  The only problem I can foresee is very minor:
there is a ref with the same name as a remote; in this case, we'd have
to specify both the remote and the ref.

Thanks.

Ram
