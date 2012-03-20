From: elton sky <eltonsky9404@gmail.com>
Subject: GSoC - Designing a faster index format
Date: Wed, 21 Mar 2012 10:10:04 +1100
Message-ID: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 00:10:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA8Bw-0002v1-Gv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 00:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757640Ab2CTXKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 19:10:06 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:43059 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab2CTXKF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 19:10:05 -0400
Received: by vbbff1 with SMTP id ff1so242323vbb.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nONG3PialY80K8XnhCqvOfi3k6KOt3BKK21ghATjd5Q=;
        b=oVW8mgPayZPNGJ887jClH9QpYODo7eixdr7EYDc3t2LvM2FFWVxPhJh2T+vj9oInoP
         HlXXjWN+bu4FD44YJmAKQ4oAKRiH17FYL7mg1IccwLbBC5/sK75HKRsfIGb4brT3PpmD
         LDa/LteUA9kMGETHcYHkWo7xMzfo05PERtYaawpKauTGn+aT3CftNFjDj83XJUGQUN2t
         nq0qnPROFo4njpgfQFJQVrm99vFZYy7Vc/TjYuhai9z9PZb11ZJN9bIpohjR1o/B3wX7
         FMwaL2213dq0OaHoJ+YyrMIbsmb0URerppiKM+9IpwA1rJmxuiEu5aQXkKS4l6mvp96z
         T6jg==
Received: by 10.220.151.198 with SMTP id d6mr750394vcw.70.1332285004684; Tue,
 20 Mar 2012 16:10:04 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Tue, 20 Mar 2012 16:10:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193550>

Hello everyone,

I am not sure if this is the right way to apply GSoC or if this
project is still available?=A0 I just subscribed a few hours ago, don't
blame me :)

I am interested with "Designing a faster index format" project.

I am new to git, only started using git yesterday.

The reasons for applying this is:
1. I like C
2. I like doing optimization
3. I want to contribute to a open source project - to git, a plus

=46rom the idea, I realize the problem is that index is verified and
rewritten on any operations which is unnecessary sometimes. And the
objective is to reduce the number of operations to below logN.=A0 As I
am new to git, I=A0 I couldn't give a detailed plan to this for now. I
should have gonna through more documents or codes but there's only one
week for application. So I have to jump up from nowhere :P

I got questions like: how each operations affect index? how cache tree
data and index is stored?
Maybe you can point me how I should catch up quickly. I went through
the article "git-for-computer-scientists", that quite makes sense.

About me:

My name is Elton Tian, I am from China. I have been living in
Australia for quite a few years. I am currently a Master student from
Australia National University. I have lots of experience in C during
my undergraduate: socket, RPC, pthread, etc.. After graduate I worked
with linux based web development for 2.5 years. We used tcl, apache
and cvs. Last year, as a student project, I had chance to benchmark
and modify hadoop distributed file system and mapreduce on a small
cluster. I have to configure and maintain the cluster by myself.

My IRC nick is "eltonsky".


Regards,
Elton
