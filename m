From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 11/13] pretty: support padding placeholders, %< %> and %><
Date: Wed, 17 Apr 2013 19:45:41 +1000
Message-ID: <CACsJy8AsWP8C4W=h8eVQbHMvvNT8Fd6iZV+P6edooMacGHfRwg@mail.gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com> <1366100702-31745-12-git-send-email-pclouds@gmail.com>
 <7v1uaaky2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 11:46:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USOwV-0001WS-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 11:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966095Ab3DQJqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 05:46:14 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42397 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966087Ab3DQJqM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 05:46:12 -0400
Received: by mail-ob0-f179.google.com with SMTP id tb18so1250964obb.38
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=DtxAJzAwByFdVu1AMpVRHQqObm4QWagOEx72OzGf3X4=;
        b=D3h16W5gMPEhRbhXW27EhFP1M87WEdTrbRur6FqZ8cfm7hgLLbQFhVQDmRhIqIFQV2
         WSQAJcaJc45DRvtUKu0Ts97ywsEOsNOntNtxuCwYcRgzXyk0NeZhQMiF4uIU9r7hCEM5
         VwMA+3vkbR1X3xUjt5m8Wb+bSbzhwhDLZ2RLsScpccj68ZWoB3dxcvN72Y6advC8y/FD
         gOKkS4R98zPMpVAorb1lVm/GgO5z1qlnVUWvClOlTNT7GoN/+DP+N1LIOCSPIWe8WoyV
         36KMy4VMi0EGQMCIRfMWdRZOgUBAByTYRoPGBI0TzpoYG7zhYmzaHt4tswaCAHcwRKgd
         TH/Q==
X-Received: by 10.60.142.230 with SMTP id rz6mr2313954oeb.22.1366191972035;
 Wed, 17 Apr 2013 02:46:12 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 02:45:41 -0700 (PDT)
In-Reply-To: <7v1uaaky2q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221526>

On Wed, Apr 17, 2013 at 6:41 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +delete_trailing_dollar() {
>> +     sed 's/\$$//'
>> +}
>
> This is what we have qz_to_tab_space for, isn't it?

Thanks! I looked for something like this, but my eyes focused on
similar sed line and forgot the "tr"
--
Duy
