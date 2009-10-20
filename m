From: Mohamed Bamakhrama <bamakhrama@gmail.com>
Subject: ".dirty" suffix when building git from the source code
Date: Tue, 20 Oct 2009 13:59:05 +0200
Message-ID: <40378e40910200459i14b06002k1b805936e39b5022@mail.gmail.com>
Reply-To: bamakhrama@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 14:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0DNF-000410-F2
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 13:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZJTL7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 07:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZJTL7W
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 07:59:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:36233 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbZJTL7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 07:59:21 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1993298fga.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:from:date
         :message-id:subject:to:content-type;
        bh=hIUK8P2R/dJMvegML01JX5YJ55iz5yLrt2MaXWYBVO4=;
        b=dvXdLrcbU/yZmbAepdAos0Wph1qTw+01ToW18ell8/kUrI5Y89Ihj7zw8kIi6fEuPy
         883ay2tPeQipwpoIZ8PHWDGqGakW5uIek1ZInLo25eAXnQDHTOFa8LufhMr3pgmK4IWw
         rme6chQR4im3RquzoZBnxW1a0NBJ6nzw/utXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:from:date:message-id:subject:to:content-type;
        b=ub+nOtLbpexx07VYkO5RZ2WgePyG3W5FHo5z7ZaQVHV9aP4hIjEI5Ddn4OQWv+4gYO
         eDixVheDy/IIeJwanznnn/PHsjYH+6WiFGqzNpxmlX7j92aww/va0LVswB8JcLQP7ngs
         2HGzOglI81Q35PwkbxKP9GmwojNt4X7M0boow=
Received: by 10.86.158.5 with SMTP id g5mr3757707fge.32.1256039965153; Tue, 20 
	Oct 2009 04:59:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130787>

Hi all,

I have cloned the git repository and built the v1.6.4.4 tag. The
compilation went OK and I got the tool up and running. However, when I
generate patches, I see that the tool comments the patches with
"1.6.4.4.dirty".

My question is: what is the meaning of the ".dirty" suffix?

Thanks in advance.

Best Regards,
Mohamed
