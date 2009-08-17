From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 19:40:44 +0200
Message-ID: <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
	 <4A899495.8050902@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Johannes.Schindelin@gmx.de
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:40:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md6CU-00025P-1D
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbZHQRkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 13:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbZHQRkp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:40:45 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:52933 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbZHQRko convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 13:40:44 -0400
Received: by qyk34 with SMTP id 34so2285970qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C6Vk7wBTXweP50QsM3V3jDVJmUvi2NprwqVeMdfbmWo=;
        b=RofpubcQj1WgyAI/x5Zj/FkAt9g7danxgcqncxUU1YCfxuBP01n3jL79oKRIJdLMdF
         ykZ0aMYV8fhqRLlB4FmUGPFncGtvKXs7SfUttFOTNfkTm7QdDtz3D+MtMDJ4+f2INNwQ
         xeFaq/MCYXt4ZFAND+rvB24rvduRWXFSi01JA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AxR7KgoejZrmGTu+XXL+lS2G29qwW0PpH26kBFsDODlprgVrrs+KZd2BtkbhjtcjYQ
         iQUb9ksDlFeYjVkiE/N2D/UOnR57QTCpL0a3ccAhkwhX/YaDcDLha5k9G6O+9VkAhZG4
         ihvrlocuhEQjOypGsoM3UoeghvKVkR1AcZ1b0=
Received: by 10.224.100.132 with SMTP id y4mr4472896qan.279.1250530844795; 
	Mon, 17 Aug 2009 10:40:44 -0700 (PDT)
In-Reply-To: <4A899495.8050902@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126245>

On Mon, Aug 17, 2009 at 7:34 PM, Paolo Bonzini<bonzini@gnu.org> wrote:
> Also, a cleaner XML without verbosities like
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <Tool
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Name=3D=
"VCMIDLTool"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 />
>
> would make the patch easier to review.

=2E..but will it make it more annoying to maintain in the long run? It
might be painful to work with a mixture of hand-written and
msdev-written XML. Of course, if we get some scripts in place to
generate the vcproj-files this might not be a problem...


--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
