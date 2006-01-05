From: Alex Riesen <raa.lkml@gmail.com>
Subject: use GIT_DIR instead of /var/tmp
Date: Thu, 5 Jan 2006 12:52:07 +0100
Message-ID: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11297_32699668.1136461927704"
X-From: git-owner@vger.kernel.org Thu Jan 05 12:52:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuTfi-0001Ms-P6
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 12:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWAELwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 06:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWAELwn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 06:52:43 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:21630 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750994AbWAELwm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 06:52:42 -0500
Received: by nproxy.gmail.com with SMTP id x37so103674nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 03:52:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=CxJd7MWa/Y+5gc5Kk/vEg/pxz+y9Xq+b58VxtJFGHoNRaa+DL1fiIBAPa/NLMYwuawbntOQOZ4GD+R/fS8EmgSB/kM513wG9BI82YnxD8uFya3iW2HNBjR0ROtpb7z9SG29GtYmKbY5g66m/0SGTIhNIfmL4gznvq0grpbOGvRw=
Received: by 10.48.142.8 with SMTP id p8mr683400nfd;
        Thu, 05 Jan 2006 03:52:07 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 03:52:07 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14192>

------=_Part_11297_32699668.1136461927704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Not every system (will not one microsoft windows system) have /var/tmp,
whereas using GIT_DIR for random temporary files is more or less establishe=
d.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_11297_32699668.1136461927704
Content-Type: text/plain; name="0006-use-GIT_DIR-instead-of-var-tmp.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0006-use-GIT_DIR-instead-of-var-tmp.txt"

U3ViamVjdDogW1BBVENIXSB1c2UgR0lUX0RJUiBpbnN0ZWFkIG9mIC92YXIvdG1wCgpTaWduZWQt
b2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgoKCi0tLQoKIGdpdC1yZXNl
dC5zaCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9ucygtKQoKOWJhM2ZhNzg2ZTNkZTY0NGE5Mzk1Zjk5ZTY5Y2VkZTkxMmY2NDU3MQpkaWZmIC0t
Z2l0IGEvZ2l0LXJlc2V0LnNoIGIvZ2l0LXJlc2V0LnNoCmluZGV4IGViNDRlZTguLjZjOWU1OGEg
MTAwNzU1Ci0tLSBhL2dpdC1yZXNldC5zaAorKysgYi9naXQtcmVzZXQuc2gKQEAgLTMsNyArMyw3
IEBACiBVU0FHRT0nWy0tbWl4ZWQgfCAtLXNvZnQgfCAtLWhhcmRdICBbPGNvbW1pdC1pc2g+XScK
IC4gZ2l0LXNoLXNldHVwCiAKLXRtcD0vdmFyL3RtcC9yZXNldC4kJAordG1wPSR7R0lUX0RJUn0v
cmVzZXQuJCQKIHRyYXAgJ3JtIC1mICR0bXAtKicgMCAxIDIgMyAxNQogCiByZXNldF90eXBlPS0t
bWl4ZWQKLS0gCjEuMC5HSVQK
------=_Part_11297_32699668.1136461927704--
