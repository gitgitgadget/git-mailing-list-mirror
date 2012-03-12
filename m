From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 20:14:40 +0100
Message-ID: <4F5E4B20.5080709@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:14:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Ahj-0001hV-B2
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 20:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab2CLTOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 15:14:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46033 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444Ab2CLTOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 15:14:42 -0400
Received: by eaaq12 with SMTP id q12so1401669eaa.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 12:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=V9eDYWxQjDcyJuDwexrN+uFg2QC/dXs38QRty9BteMY=;
        b=Sj4ZpjeLmZMhfVkQROL3y6uR2t+6vmjWsbxS0+zpzSXa12zRWJUiZxs3dhJxW7RykU
         XF8CwV/geAFZQd/D26uHIltMuHD1ikGSSAS8tWnxwjW8C1xZC8k6J+iVZVjgf5ZYq+Mf
         WFFy5CKkkB8a//pSiptz5pP9/ERVa91Hnnm2YSoYCG5L09OT7uSzxqKKBIe+8bTzPCBQ
         yb0jitdKbCKgbBNmsRjUD8IKOYiLxqIdWijnh7qGzq7JNXhKgJclYK1tTDguUhq+p3vQ
         o4fFQqhtdw64masOi7M2hftqXufI4ZEYm+GpduartvU2yiuwZwFUDkoaw1DVjmak97D8
         /lLg==
Received: by 10.213.34.16 with SMTP id j16mr1092155ebd.124.1331579680864;
        Mon, 12 Mar 2012 12:14:40 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id u9sm52946952eem.11.2012.03.12.12.14.40
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 12:14:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
X-Gm-Message-State: ALoCoQlf0m33qmlR9aVD3S9GLzGZf0GDnX1u1yVb/dCnCd/HivlEDxbXpO/nl2JNe5UmoKpuP/bv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192926>

Hi all,

Would it be a useful addition to have a command 'git rerere edit <path> 
<commit>' ?

This would allow the user to edit the conflict resolution which was used 
in a certain commit (merge, rebase.. ).

Now I tend to grep in the .git/rr-cache directory, because I don't want 
to do 'git rerere forget' as this would require me to refix more 
resolution than needed.

Vincent
