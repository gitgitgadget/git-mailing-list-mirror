From: "John Yesberg" <john.yesberg@gmail.com>
Subject: clone git over http fails - Unable to find 1f405709e7341c27e20c0159fb7c17efbf85975c
Date: Wed, 11 Jun 2008 15:58:25 +0100
Message-ID: <1033a22d0806110758mdec211dr21e0115e0eb1fb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 16:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6RnG-0007Ia-Kd
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 16:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbYFKO61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 10:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbYFKO61
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 10:58:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:59184 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYFKO60 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 10:58:26 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1848730wri.5
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Eq5K8WvlsUJMZryQ3kZNdvLfq6BU7HOD+p8m9Z5j9iA=;
        b=Ys4smEGhMN8K8WeW0Lmnr0GgBlKb0dRe/VsyJVsrkRCExkBVOE4ZV3KGvZVrRmRjmf
         lSehW6BaNYlt9l/xO7lxWPaWHghf8q/O2YWRlN5UjAEkGVdkCIYmvSW8dI/PeA12d4yS
         cjZrauEicJlPQxQ49mKxNgHtEUfXS6UL647pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=uYlr12MDImbP8frGUiNV+rtIhMXa+fVJtSHQ0rThgT8oeGHfInNvwO/aLfuDzTOeRg
         cVmwQOMZA88kCO7ljBNkisU/iYgLll3/rQGUO7Na5f4RoB4mFoKRsakjCVf99AN2d3Mi
         reXyAcdVMtUYPHTrz8rm/SIxkUoF+McvPyrVM=
Received: by 10.151.106.7 with SMTP id i7mr363736ybm.176.1213196305107;
        Wed, 11 Jun 2008 07:58:25 -0700 (PDT)
Received: by 10.151.14.21 with HTTP; Wed, 11 Jun 2008 07:58:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84614>

Hi,

I'm trying to clone the git repository, but I'm behind an http proxy.
I'm using v1.5.5.1015.g9d258 (the msys distro)
   $ git clone http://www.kernel.org/pub/scm/git/git.git
seems to collect files in a different order each time, but always
fails at some point with:
   error: Unable to find 1f405709e7341c27e20c0159fb7c17efbf85975c
under http://www.kernel.org/pub/scm/git/git.git

Am I doing something silly?

John.

$ git clone http://www.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in [path]/git/.git/
got dc8f25ba925d69ae6cd9477948a4681a6b9ba881
walk dc8f25ba925d69ae6cd9477948a4681a6b9ba881
got 0a18b3535038faaf8564a7d20066913c4d9d14f9
got 436b5eada7e01dd9bcf5edfd6faf2339585e5ebd
walk 0a18b3535038faaf8564a7d20066913c4d9d14f9
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git
Getting pack list for http://www.kernel.org/pub/scm/git/git.git
Getting index for pack f7be43530c5b167d6eff8e1d4ee72d7c98aa6710
Getting index for pack 38b949b3b9446f6ef31fe3bc5a70b09cf8cc5c82
Getting index for pack 535070eccfdc5b080d4b38e682f66b357f3cb4bd
Getting index for pack fb9e204382bfea5b1821f19b7a9e82d0e5be8498
Getting index for pack fd67c0ccebfbe7d87dedb7eb0e12307a0d5f7033
Getting index for pack 64f30462eb1335d26f28ece3a98fc0047307a5c2
Getting index for pack d8521ceb53941f13b1785565d83d91c9d0b67953
Getting index for pack e1936328f919a351933f66479e63ab567d4e4d48
Getting index for pack 77c896700c1afe4fd8fd07991b83fb3a64d87ae4
Getting index for pack 75e4acddbaeee25ccc748565c08c5c53dd9e1b1a
Getting index for pack 37a7ccefb9278b60c4ebb5b865ac9605dca4809f
Getting index for pack e489f28845f3ac96238395a43491ad8a5338bd89
Getting index for pack ddface50024cc582622a0699b16b70889e2a11ea
Getting index for pack b7c114d95a6aac204689081e16db1bf9cd0452c8
Getting index for pack 5cce297d441c39b631efba1220c384b3d964f067
got 89fa6d03bc038d6210e94d7fe9fbbffdbc84d883
Getting index for pack 62362766219c21ac80c18105230f663514ad34c6
got 02823413987d5a10364d936327e3a1cfb38cbac2
Getting index for pack cffea011357566718ddc7174cb5e4ee3a567297d
got 7de419708f77fff6f61e749b917b5fcecbe9a292
got 391a7b02eaf32d930e7c9c274dfd2a2edf081f75
got f22f98b734f82101d47a6aa2453d5374d5dd8175
Getting index for pack 06b099900025b5c376d5b8a153935341e9e4d0c9
got 2d0279ecce622aab935e8e25914a5bd132fa95f3
got 29322124881bf65c3ee6f5d613251b09f4a98d9a
got a79e4b93935a7e0aff1b72495b0ee5947df73c0a
Getting index for pack c3b2cfff0f8443cddcc2eccd25ee9ddb1d42125c
Getting index for pack f21a6e46196419f7808b68b7edb1a4863574b348
Getting index for pack 7443244f6593721f7d21de681b4afca3dade533e
got 514de13d648e0396d97580591c263a314d61fcc3
Getting index for pack 0651d930b1118d4cfd6c9e69df89a8bc42946ab0
Getting index for pack 3e77f65f4835620e37c44ac540d3b32d66a6fab9
Getting index for pack a757cf1853c02d678571339b2d067d17de307fa7
Getting index for pack 839f19d7b17bc926401176afbf2c32d00f8dd674
Getting index for pack 9ed0df938f57d4a22fb9a3ae5d803caf61a3b4f6
Getting index for pack a6ac239633cf250feed5b3da9a1a4ef4426fa474
Getting index for pack fd656207f2bf86fb5a8fe53509ff114ed8d668dd
Getting index for pack 24d8ea6e4e9a8c41be9ddac8f6b13007a407b451
Getting index for pack 7ab8f1add7c1f86e9cea3d84295e737a471bfafd
got e598cdda45cf0b953a106d6786765b3316e2cc16
Getting index for pack beb5b4f6cd73218ba89a8b29da076ac354c77c89
Getting index for pack e1af065a52661db8f4beb51e89b87a63e08ba430
Getting index for pack a8e57afde145c4e131151d20ca38d31aaa64c34a
Getting index for pack 1abd19356edae7ee9392fae411849e0d4aa0673c
Getting index for pack fd480613c039ddd36a63f684ebf13a56f2797441
Getting index for pack 22dad577783ab2beab4d0e7b46ce44cc2bddbabf
Getting index for pack ca69ef65b7ba24a9875b4585190aa9735193a4e2
Getting index for pack b9eccb0ceecbd0418d409cd21a5213760c2e7cfd
Getting index for pack 8a64d69528ffe99489891c3645c6d88521d88028
Getting index for pack c4273115303075bf09de97dc257a28a0a4d2057a
Getting index for pack 9c593cb9b0f40b4686b9574f244f81fd894cc480
Getting index for pack e0527155e317b0e4613f5fc5166136c0edb505e9
Getting index for pack 6d98795769575789a38066c73c71c61ca79a7dd9
Getting index for pack 17d608d0bea63b7c5b68bccd1515e9c5ac0961c5
Getting index for pack 3aa9bf1b4161513050d59d937c5b880f71d9090f
Getting index for pack 0b3eb3c8d545d827eb1ec58976c288dd18185566
Getting index for pack 1dbb69127c8efb2534f925b7cf031b0a2428e8b4
Getting index for pack 35dd9c96344d38867f0adc285d8aca87cd5b3cb7
Getting index for pack c97bd293b33c5419b998e340d91863f0d68a3dd0
Getting index for pack 23b927484f61441ff7f1bf3f7527aafadef62478
Getting index for pack d252ddba5ff09337bb776a7febfabae4351a82ad
got ba07cd5b021f947b7efeb1e73498225ea633db3e
got f58013ca605631437e5a4806cdd07dba18d8a982
Getting pack f7be43530c5b167d6eff8e1d4ee72d7c98aa6710
 which contains fea3f9935b7794ce86f04d22c9d68fb9d537167d
Getting pack 23b927484f61441ff7f1bf3f7527aafadef62478
 which contains 5428111d732cb38dbb257ddfa860ebd04088b4e9
Getting pack d252ddba5ff09337bb776a7febfabae4351a82ad
 which contains 5331b450ea051334d53ce3f1e727e33def2ea2cf
Getting pack 3aa9bf1b4161513050d59d937c5b880f71d9090f
 which contains 572154834b35675ccf56920efd540bf872d1ab25
Getting pack 1dbb69127c8efb2534f925b7cf031b0a2428e8b4
 which contains cb4b83de1eb48d163480185da54a828c5bb20941
error: Unable to find 1f405709e7341c27e20c0159fb7c17efbf85975c under
http://www.kernel.org/pub/scm/git/git.git
Cannot obtain needed blob 1f405709e7341c27e20c0159fb7c17efbf85975c
while processing commit 0a18b3535038faaf8564a7d20066913c4d9d14f9.
rm: cannot remove directory `[path]/git/.git/clone-tmp': Directory not empty
rm: cannot remove directory `[path]/git/.git': Directory not empty
rm: cannot remove directory `[path]/git': Directory not empty
